{ lib, ... }:
{
  plugins.snacks.settings.picker = {
    settings = {
      picker = {
        enabled = true;
        sources = {
          explorer = {
            hidden = true;
            ignored = true;
          };
          files = {
            hidden = true;
            ignored = true;
          };
        };
        hidden = true;
        ignored = true;
        exclude = [
          "node_modules/"
          "dist/"
          ".git/"
          "build/"
          "target"
        ];
      };
    };
  };

  keymaps = [
    #   {
    #     mode = "n";
    #     key = "<leader>..";
    #     action = "<cmd>:lua Snacks.scratch()<cr>";
    #     options.desc = "Toggle Scratch Buffer";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>.s";
    #     action = "<cmd>:lua Snacks.scratch.select()<cr>";
    #     options.desc = "Select Scratch Buffer";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sn";
    #     action = "<cmd>:lua Snacks.notifier.show_history()<cr>";
    #     options.desc = "Notification History";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>.r";
    #     action = "<cmd>:lua Snacks.rename.rename_file()<cr>";
    #     options.desc = "Rename file/variable +lsp";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>gB";
    #     action = "<cmd>:lua Snacks.gitbrowse()<cr>";
    #     options.desc = "Git Browse";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>gf";
    #     action = "<cmd>:lua Snacks.lazygit.log_file()<cr>";
    #     options.desc = "Lazygit Current File History";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>gB";
    #     action = "<cmd>:lua Snacks.gitbrowse()<cr>";
    #     options.desc = "Git Browse";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>gf";
    #     action = "<cmd>:lua Snacks.lazygit.log_file()<cr>";
    #     options.desc = "Lazygit Current File History";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>gg";
    #     action = "<cmd>:lua Snacks.lazygit()<cr>";
    #     options.desc = "Lazygit";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>gl";
    #     action = "<cmd>:lua Snacks.lazygit.log()<cr>";
    #     options.desc = "Lazygit Log (cwd)";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>gL";
    #     action = "<cmd>:lua Snacks.picker.git_log()<cr>";
    #     options.desc = "Git Log (cwd)";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>un";
    #     action = "<cmd>:lua Snacks.notifier.hide()<cr>";
    #     options.desc = "Dismiss All Notifications";
    #   }
    #
    #   {
    #     mode = "n";
    #     key = "<leader>sb";
    #     action = "<cmd>:lua Snacks.picker.lines() <cr>";
    #     options.desc = "Buffer Lines";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sB";
    #     action = "<cmd>:lua Snacks.picker.grep_buffers() <cr>";
    #     options.desc = "Grep Open Buffers";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sg";
    #     action = "<cmd>:lua Snacks.picker.grep() <cr>";
    #     options.desc = "Grep";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sw";
    #     action = "<cmd>:lua Snacks.picker.grep_word() <cr>";
    #     options.desc = "Visual selection or word";
    #   }
    #   {
    #     mode = "x";
    #     key = "<leader>sw";
    #     action = "<cmd>:lua Snacks.picker.grep_word() <cr>";
    #     options.desc = "Visual selection or word";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>s";
    #     action = "<cmd>:lua Snacks.picker.registers() <cr>";
    #     options.desc = "Registers";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sa";
    #     action = "<cmd>:lua Snacks.picker.autocmds() <cr>";
    #     options.desc = "Autocmds";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sb";
    #     action = "<cmd>:lua Snacks.picker.lines() <cr>";
    #     options.desc = "Buffer Lines";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sc";
    #     action = "<cmd>:lua Snacks.picker.command_history() <cr>";
    #     options.desc = "Command History";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sC";
    #     action = "<cmd>:lua Snacks.picker.commands() <cr>";
    #     options.desc = "Commands";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sd";
    #     action = "<cmd>:lua Snacks.picker.diagnostics() <cr>";
    #     options.desc = "Diagnostics";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sD";
    #     action = "<cmd>:lua Snacks.picker.diagnostics_buffer() <cr>";
    #     options.desc = "Buffer Diagnostics";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sH";
    #     action = "<cmd>:lua Snacks.picker.highlights() <cr>";
    #     options.desc = "Highlights";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>si";
    #     action = "<cmd>:lua Snacks.picker.icons() <cr>";
    #     options.desc = "Icons";
    #   }
    {
      mode = "n";
      key = "<leader>sj";
      action = "<cmd>:lua Snacks.picker.jumps() <cr>";
      options.desc = "Jumps";
    }
    #   {
    #     mode = "n";
    #     key = "<leader>sl";
    #     action = "<cmd>:lua Snacks.picker.loclist() <cr>";
    #     options.desc = "Location List";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sm";
    #     action = "<cmd>:lua Snacks.picker.marks() <cr>";
    #     options.desc = "Marks";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sM";
    #     action = "<cmd>:lua Snacks.picker.man() <cr>";
    #     options.desc = "Man Pages";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sq";
    #     action = "<cmd>:lua Snacks.picker.qflist() <cr>";
    #     options.desc = "Quickfix List";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sR";
    #     action = "<cmd>:lua Snacks.picker.resume() <cr>";
    #     options.desc = "Resume";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>su";
    #     action = "<cmd>:lua Snacks.picker.undo() <cr>";
    #     options.desc = "Undo History";
    #   }
    #
    #   {
    #     mode = "n";
    #     key = "gd";
    #     action = "<cmd>:lua Snacks.picker.lsp_definitions() <cr>";
    #     options.desc = "Goto Definition";
    #   }
    #   {
    #     mode = "n";
    #     key = "gD";
    #     action = "<cmd>:lua Snacks.picker.lsp_declarations() <cr>";
    #     options.desc = "Goto Declaration";
    #   }
    #   {
    #     mode = "n";
    #     key = "gr";
    #     action = "<cmd>:lua Snacks.picker.lsp_references() <cr>";
    #     options.desc = "References";
    #   }
    #   {
    #     mode = "n";
    #     key = "gI";
    #     action = "<cmd>:lua Snacks.picker.lsp_implementations() <cr>";
    #     options.desc = "Goto Implementation";
    #   }
    #   {
    #     mode = "n";
    #     key = "gy";
    #     action = "<cmd>:lua Snacks.picker.lsp_type_definitions() <cr>";
    #     options.desc = "Goto T[y]pe Definition";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>ss";
    #     action = "<cmd>:lua Snacks.picker.lsp_symbols() <cr>";
    #     options.desc = "LSP Symbols";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sS";
    #     action = "<cmd>:lua Snacks.picker.lsp_workspace_symbols() <cr>";
    #     options.desc = "LSP Workspace Symbols";
    #   }
    #
    #   # Telescope replacement
    #   {
    #     mode = "n";
    #     key = "<leader>sP";
    #     action = "<cmd>:lua Snacks.picker()<cr>";
    #     options.desc = "Pickers";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>ss";
    #     action = "<cmd>:lua Snacks.picker.smart()<cr>";
    #     options.desc = "Smart";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>st";
    #     action = "<cmd>:lua Snacks.picker.todo_comments({layout = 'ivy'})<cr>";
    #     options.desc = "Todo";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sT";
    #     action = ''<cmd>:lua Snacks.picker.todo_comments({keywords = {"TODO", "FIX", "FIXME"}, layout = 'ivy'})<cr>'';
    #     options.desc = "Todo";
    #   }
    #
    #   {
    #     mode = "n";
    #     key = "<leader>s:";
    #     action = ''<cmd>:lua Snacks.picker.command_history({ layout = 'ivy'})<cr>'';
    #     options.desc = "Command History";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>s,";
    #     action = ''<cmd>:lua Snacks.picker.buffers({layout = 'ivy'})<cr>'';
    #     options.desc = "Buffers";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sh";
    #     action = "<cmd>:lua Snacks.picker.help()<cr>";
    #     options.desc = "Help Pages";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>sk";
    #     action = ''<cmd>:lua Snacks.picker.keymaps({layout = 'vscode'}}<cr>'';
    #     options.desc = "Keymaps";
    #   }
    #
    #   {
    #     mode = "n";
    #     key = "<leader>su";
    #     action = (
    #       # lua
    #       lib.nixvim.mkRaw ''
    #         function()
    #           Snacks.picker.undo({
    #             win = {
    #               input = {
    #                 keys = {
    #                   ["y"] = { "yank_add", mode =  "n" },
    #                   ["Y"] = { "yank_del", mode =  "n" },
    #                 },
    #               },
    #             },
    #           })
    #         end
    #       ''
    #     );
    #     options.desc = "Undo";
    #   }
    #
    #   {
    #     mode = "n";
    #     key = "<leader>ff";
    #     action = "<cmd>:lua Snacks.picker.files()<cr>";
    #     options.desc = "Find Files";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>fF";
    #     action = "<cmd>:lua Snacks.picker.smart()<cr>";
    #     options.desc = "Smart";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>f/";
    #     action = "<cmd>:lua Snacks.picker.grep()<cr>";
    #     options.desc = "Grep";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>f?";
    #     action = ''<cmd>:lua Snacks.picker.grep({layout = 'ivy', args = { '--vimgrep', '--smart-case', '--fixed-strings' } })<cr>'';
    #     options.desc = "Grep";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>fr";
    #     action = "<cmd>:lua Snacks.picker.recent()<cr>";
    #     options.desc = "Recent";
    #   }
    #   {
    #     mode = "n";
    #     key = "<leader>fp";
    #     action = "<cmd>:lua Snacks.picker.projects()<cr>";
    #     options.desc = "Projects";
    # }
  ];
}
