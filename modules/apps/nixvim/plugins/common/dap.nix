{ pkgs, ... }:
let
  # Общая функция для поиска корня проекта (package.json)
  root_func = "function() local path = vim.fn.findfile('package.json', vim.fn.expand('%:p:h') .. ';'); if path == '' then return vim.fn.getcwd() end return vim.fn.fnamemodify(path, ':p:h') end";

  # Расширенная функция для запроса хоста и порта
  url_func = ''
    function()
      local host = vim.fn.input('Host [127.0.0.1]: ')
      if host == "" then host = "127.0.0.1" end
      local port = vim.fn.input('Port [3000]: ')
      if port == "" then port = "3000" end
      return 'http://' .. host .. ':' .. port
    end
  '';

  # Общие конфигурации для браузеров и NestJS
  common_web_configs = [
    {
      type = "pwa-node";
      request = "launch";
      name = "Debug NestJS";
      cwd.__raw = root_func;
      runtimeExecutable = "npm";
      runtimeArgs = [
        "run"
        "start:debug"
        "--"
        "--inspect-brk"
      ];
      autoAttachChildProcesses = true;
      restart = true;
      sourceMaps = true;
      console = "integratedTerminal";
      internalConsoleOptions = "neverOpen";
      skipFiles = [
        "<node_internals>/**"
        "node_modules/**"
        "**/node_modules/**"
      ];
      resolveSourceMapLocations = [
        "\${workspaceFolder}/**"
        "!**/node_modules/**"
      ];
    }
    {
      type = "pwa-chrome";
      request = "launch";
      name = "Launch Chrome against localhost";
      url.__raw = url_func;
      webRoot.__raw = root_func;
    }
    {
      type = "firefox";
      request = "launch";
      name = "Launch Firefox against localhost";
      url.__raw = url_func;
      webRoot.__raw = root_func;
      reAttach = true;
      firefoxExecutable = "${pkgs.firefox}/bin/firefox";
      firefoxArgs = [
        "--start-debugger-server"
        "6000"
      ];
    }
    {
      type = "firefox";
      request = "attach";
      name = "Attach to Firefox";
      url.__raw = url_func;
      webRoot.__raw = root_func;
    }
  ];

  # Конфигурация для "чистого" запуска JS файла
  js_file_config = {
    type = "pwa-node";
    request = "launch";
    name = "Launch file";
    program = "\${file}";
    cwd.__raw = root_func;
  };

  # Конфигурация для "чистого" запуска TS файла
  ts_file_config = {
    type = "pwa-node";
    request = "launch";
    name = "Launch file";
    program = "\${file}";
    cwd.__raw = root_func;
    runtimeArgs = [
      "--loader"
      "ts-node/register"
    ];
    sourceMaps = true;
    protocol = "inspector";
    console = "integratedTerminal";
  };

  # Конфигурация Attach (универсальная для node)
  node_attach_config = {
    type = "pwa-node";
    request = "attach";
    name = "Attach to Node Process";
    processId.__raw = "require('dap.utils').pick_process";
    cwd.__raw = root_func;
  };

in
{
  plugins = {
    dap-virtual-text.enable = true;
    dap = {
      enable = true;
      signs = {
        dapBreakpoint = {
          text = " ";
          texthl = "DiagnosticInfo";
        };
        dapBreakpointCondition = {
          text = " ";
          texthl = "DiagnosticInfo";
        };
        dapBreakpointRejected = {
          text = " ";
          texthl = "DiagnosticError";
        };
        dapLogPoint = {
          text = " ";
          texthl = "DiagnosticInfo";
        };
        dapStopped = {
          text = "󰁕 ";
          texthl = "DiagnosticWarn";
          linehl = "DapStoppedLine";
          numhl = "DapStoppedLine";
        };
      };
      adapters = {
        pwa-node = {
          __raw = ''
            {
              type = "executable",
              command = "${pkgs.vscode-js-debug}/bin/js-debug",
              args = {},
            }
          '';
        };
        pwa-chrome = {
          __raw = ''
            {
              type = "executable",
              command = "${pkgs.vscode-js-debug}/bin/js-debug",
              args = {},
            }
          '';
        };
        firefox = {
          __raw = ''
            {
              type = "executable",
              command = "node",
              args = { "${pkgs.vscode-extensions.firefox-devtools.vscode-firefox-debug}/share/vscode/extensions/firefox-devtools.vscode-firefox-debug/dist/adapter.bundle.js" },
            }
          '';
        };
      };
      configurations = {
        javascript = [
          js_file_config
          node_attach_config
        ]
        ++ common_web_configs;
        javascriptreact = [
          js_file_config
          node_attach_config
        ]
        ++ common_web_configs;
        typescript = [
          ts_file_config
          node_attach_config
        ]
        ++ common_web_configs;
        typescriptreact = [
          ts_file_config
          node_attach_config
        ]
        ++ common_web_configs;
        vue = [
          ts_file_config
          node_attach_config
        ]
        ++ common_web_configs;
      };
    };
    dap-ui.enable = true;
    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>d";
        mode = [
          "n"
          "v"
        ];
        group = "Debug";
      }
    ];
  };

  extraConfigLua = ''
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  '';

  keymaps = [
    {
      mode = [ "n" ];
      action = ":DapContinue<cr>";
      key = "<leader>dc";
      options = {
        desc = "Continue";
      };
    }
    {
      mode = [ "n" ];
      action = ":DapStepOver<cr>";
      key = "<leader>dO";
      options = {
        desc = "Step over";
      };
    }
    {
      mode = [ "n" ];
      action = ":DapStepInto<cr>";
      key = "<leader>di";
      options = {
        desc = "Step Into";
      };
    }
    {
      mode = [ "n" ];
      action = ":DapStepOut<cr>";
      key = "<leader>do";
      options = {
        desc = "Step Out";
      };
    }
    {
      mode = [ "n" ];
      action = "<cmd>lua require('dap').pause()<cr>";
      key = "<leader>dp";
      options = {
        desc = "Pause";
      };
    }
    {
      mode = [ "n" ];
      action = ":DapToggleBreakpoint<cr>";
      key = "<leader>db";
      options = {
        desc = "Toggle Breakpoint";
      };
    }
    {
      mode = [ "n" ];
      action = "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>";
      key = "<leader>dB";
      options = {
        desc = "Breakpoint (conditional)";
      };
    }
    {
      mode = [ "n" ];
      action = ":DapToggleRepl<cr>";
      key = "<leader>dR";
      options = {
        desc = "Toggle REPL";
      };
    }
    {
      mode = [ "n" ];
      action = "<cmd>lua require('dap').run_last()<cr>";
      key = "<leader>dr";
      options = {
        desc = "Run Last";
      };
    }
    {
      mode = [ "n" ];
      action = "<cmd>lua require('dap').session()<cr>";
      key = "<leader>ds";
      options = {
        desc = "Session";
      };
    }
    {
      mode = [ "n" ];
      action = ":DapTerminate<cr>";
      key = "<leader>dt";
      options = {
        desc = "Terminate";
      };
    }
    {
      mode = [ "n" ];
      action = "<cmd>lua require('dap.ui.widgets').hover()<cr>";
      key = "<leader>dw";
      options = {
        desc = "Hover Widget";
      };
    }
    {
      mode = [ "n" ];
      action = "<cmd>lua require('dapui').toggle()<cr>";
      key = "<leader>du";
      options = {
        desc = "Toggle UI";
      };
    }
    {
      mode = [ "n" ];
      action = "<cmd>lua require('dapui').eval()<cr>";
      key = "<leader>de";
      options = {
        desc = "Eval";
      };
    }
  ];
}
