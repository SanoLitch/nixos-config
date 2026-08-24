{ lib, ... }:
{
  plugins.conform-nvim = {
    enable = true;
    autoInstall.enable = true;
    settings = {
      log_level = "warn";
      notify_on_error = true;
      notify_no_formatters = true;
      format_on_save = {
        lspFallback = true;
        timeoutMs = 500;
      };
      formatters = {
        prettierd = {
          condition.__raw = ''
            function(self, ctx)
              local util = require("conform.util")

              -- 1. Проверяем отдельные файлы конфигурации
              local has_config = util.root_file({
                ".prettierrc",
                ".prettierrc.json",
                ".prettierrc.yml",
                ".prettierrc.yaml",
                ".prettierrc.json5",
                ".prettierrc.js",
                ".prettierrc.cjs",
                ".prettierrc.mjs",
                "prettier.config.js",
                "prettier.config.cjs",
                "prettier.config.mjs",
              })(self, ctx) ~= nil

              if has_config then
                return true
              end

              -- 2. Если отдельного файла нет, проверяем ключ "prettier" в package.json
              local pkg_path = util.root_file({ "package.json" })(self, ctx)
              if pkg_path then
                local content = vim.fn.readfile(pkg_path .. "/package.json")
                local ok, parsed = pcall(vim.fn.json_decode, table.concat(content, ""))
                if ok and type(parsed) == "table" then
                  local has_pkg_config = parsed.prettier ~= nil
                  local has_pkg_dep = (parsed.devDependencies and parsed.devDependencies.prettier)
                    or (parsed.dependencies and parsed.dependencies.prettier)
                  return has_pkg_config or (has_pkg_dep ~= nil)
                end
              end

              return false
            end
          '';
        };

        eslint_d = {
          condition.__raw = ''
            function(self, ctx)
              local util = require("conform.util")

              -- 1. Проверяем отдельные файлы конфигурации
              local has_config = util.root_file({
                -- Flat config (ESLint 9+)
                "eslint.config.js",
                "eslint.config.mjs",
                "eslint.config.cjs",
                "eslint.config.ts",
                "eslint.config.mts",
                "eslint.config.cts",
                -- Legacy config (ESLint <=8)
                ".eslintrc",
                ".eslintrc.js",
                ".eslintrc.cjs",
                ".eslintrc.yaml",
                ".eslintrc.yml",
                ".eslintrc.json",
              })(self, ctx) ~= nil

              if has_config then
                return true
              end

              -- 2. Если отдельного файла нет, проверяем ключ "eslint" в package.json
              local pkg_path = util.root_file({ "package.json" })(self, ctx)
              if pkg_path then
                local content = vim.fn.readfile(pkg_path .. "/package.json")
                local ok, parsed = pcall(vim.fn.json_decode, table.concat(content, ""))
                if ok and type(parsed) == "table" then
                  local has_pkg_config = parsed.eslint ~= nil
                  local has_pkg_dep = (parsed.devDependencies and parsed.devDependencies.eslint)
                    or (parsed.dependencies and parsed.dependencies.eslint)
                  return has_pkg_config or (has_pkg_dep ~= nil)
                end
              end

              return false
            end
          '';
        };

        dprint = {
          condition.__raw = ''
            function(self, ctx)
              return require("conform.util").root_file({
                "dprint.json",
                ".dprint.json",
                "dprint.jsonc",
                ".dprint.jsonc",
              })(self, ctx) ~= nil
            end
          '';
        };
      };
      formatters_by_ft = {
        "_" = [
          "squeeze_blanks"
          "trim_whitespace"
          "trim_newlines"
        ];
        html = {
          __unkeyed-1 = "dprint";
          __unkeyed-2 = "prettierd";
          stop_after_first = true;
        };
        css = {
          __unkeyed-1 = "dprint";
          __unkeyed-2 = "prettierd";
          stop_after_first = true;
        };
        javascript = {
          __unkeyed-1 = "dprint";
          __unkeyed-2 = "prettierd";
          __unkeyed-3 = "eslint_d";
          stop_after_first = true;
        };
        javascriptreact = {
          __unkeyed-1 = "dprint";
          __unkeyed-2 = "prettierd";
          __unkeyed-3 = "eslint_d";
          stop_after_first = true;
        };
        typescript = {
          __unkeyed-1 = "dprint";
          __unkeyed-2 = "prettierd";
          __unkeyed-3 = "eslint_d";
          stop_after_first = true;
        };
        typescriptreact = {
          __unkeyed-1 = "dprint";
          __unkeyed-2 = "prettierd";
          __unkeyed-3 = "eslint_d";
          stop_after_first = true;
        };
        nix = [ "nixfmt" ];
        rust = [ "rustfmt" ];
        toml = [ "taplo" ];
        markdown = {
          __unkeyed-1 = "dprint";
          __unkeyed-2 = "prettierd";
          stop_after_first = true;
        };
        sh = [ "shfmt" ];
        json = {
          __unkeyed-1 = "dprint";
          __unkeyed-2 = "prettierd";
          stop_after_first = true;
        };
      };
    };

  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>cf";
      action = "<cmd>lua require('conform').format()<cr>";
      options = {
        silent = true;
        desc = "Format Buffer";
      };
    }
  ];
}
