{
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        theme = "auto";
        component_separators = {
          left = "│";
          right = "│";
        };
        section_separators = {
          left = "";
          right = "";
        };
        globalstatus = true;
        disabled_filetypes = {
          statusline = [
            "alpha"
            "dashboard"
            "nark"
            "TelescopePrompt"
          ];
        };
      };
      sections = {
        lualine_a = [
          {
            __unkeyed-1 = "mode";
            separator.left = "";
            padding = {
              left = 0;
              right = 1;
            };
          }
        ];
        lualine_b = [
          "branch"
          "diff"
          "diagnostics"
        ];
        lualine_c = [
          {
            __unkeyed-1 = "filename";
            file_status = true;
            path = 1;
          }
        ];
        lualine_x = [
          "encoding"
          "fileformat"
          "filetype"
        ];
        lualine_y = [ "progress" ];
        lualine_z = [
          {
            __unkeyed-1 = "location";
            separator.right = "";
            padding = {
              left = 1;
              right = 0;
            };
          }
        ];
      };
    };
  };
}
