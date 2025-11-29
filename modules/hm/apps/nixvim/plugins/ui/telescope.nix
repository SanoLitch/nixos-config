{
  plugins.telescope = {
    enable = true;
    enabledExtensions = [
      # "aerial"
      "noice"
    ];
    extensions = {
      fzf-native = {
        enable = true;
        settings = {
          fuzzy = true;
          override_generic_sorter = true;
          override_file_sorter = true;
          case_mode = "smart_case";
        };
      };
      ui-select = {
        enable = true;
        settings = {
          specific_opts = {
            codeactions = true;
          };
        };
      };
    };
    settings = {
      defaults = {
        layout_strategy = "horizontal";
        layout_config = {
          horizontal = {
            prompt_position = "top";
            preview_width = 0.55;
            results_width = 0.8;
          };
        };
        sorting_strategy = "ascending";
        winblend = 0;
        border = true;
        borderchars = [
          "─"
          "│"
          "─"
          "│"
          "╭"
          "╮"
          "╯"
          "╰"
        ];
      };
      pickers = {
        colorscheme = {
          enable_preview = true;
        };
      };
    };
    keymaps = {
      "<C-p>" = {
        action = "open_with_trouble";
      };
      "<leader>:" = {
        action = "command_history";
        options.desc = "Command History";
      };
      # "<leader>b" = {
      #   action = "buffers";
      #   options.desc = "+buffer";
      # };
      "<leader>fb" = {
        action = "buffers";
        options.desc = "Buffers";
      };
      "<leader>gf" = {
        action = "git_files";
        options.desc = "Search git files";
      };
      "<leader>gc" = {
        action = "git_commits";
        options.desc = "Commits";
      };
      "<leader>gs" = {
        action = "git_status";
        options.desc = "Status";
      };
      "<leader>soa" = {
        action = "autocommands";
        options.desc = "Auto Commands";
      };
      "<leader>sob" = {
        action = "current_buffer_fuzzy_find";
        options.desc = "Buffer";
      };
      "<leader>soc" = {
        action = "command_history";
        options.desc = "Command History";
      };
      "<leader>soC" = {
        action = "commands";
        options.desc = "Commands";
      };
      "<leader>sD" = {
        action = "diagnostics";
        options.desc = "Workspace diagnostics";
      };
      "<leader>soh" = {
        action = "help_tags";
        options.desc = "Help pages";
      };
      "<leader>soH" = {
        action = "highlights";
        options.desc = "Search Highlight Groups";
      };
      "<leader>sok" = {
        action = "keymaps";
        options.desc = "Keymaps";
      };
      "<leader>soM" = {
        action = "man_pages";
        options.desc = "Man pages";
      };
      "<leader>som" = {
        action = "marks";
        options.desc = "Jump to Mark";
      };
      "<leader>so" = {
        action = "+other";
        options.desc = "Other";
      };
      "<leader>soo" = {
        action = "vim_options";
        options.desc = "Options";
      };
      "<leader>soR" = {
        action = "resume";
        options.desc = "Resume";
      };
      "<leader>sol" = {
        action = "colorscheme";
        options.desc = "Colorscheme preview";
      };
      # "<leader>fp" = {
      #   action = "projects";
      #   options.desc = "Projects";
      # };
      "<leader>sd" = {
        action = "diagnostics bufnr=0";
        options.desc = "Document Diagnostics";
      };
    };
  };
}
