{ lib, ... }:
{
  plugins.which-key = {
    enable = true;
    settings = {
      filter = lib.nixvim.mkRaw ''
        function(mapping)
          return mapping.lhs
            and mapping.desc
            and mapping.desc:find("LM") == nil
        end
      '';

      icons = {
        breadcrumb = "»";
        group = "+";
        separator = "";
      };
      win = {
        border = "rounded";
        padding = [
          1
          1
        ];
      };

      spec = [
        {
          __unkeyed-1 = "<leader>c";
          mode = [
            "n"
            "v"
          ];
          group = "Code";
        }

        {
          __unkeyed-1 = "<leader>f";
          mode = "n";
          group = "Find";
        }

        {
          __unkeyed-1 = "<leader>g";
          mode = [
            "n"
            "v"
          ];
          group = "Git";
        }

        {
          __unkeyed-1 = "<leader>s";
          mode = "n";
          group = "Search";
        }

        {
          __unkeyed-1 = "<leader>u";
          mode = "n";
          group = "Utils";
        }

        {
          __unkeyed-1 = "<leader>w";
          mode = "n";
          group = "Windows";
        }

        {
          __unkeyed-1 = "<leader>b";
          mode = "n";
          group = "Buffers";
        }

        {
          __unkeyed-1 = "<leader>x";
          mode = "n";
          group = "Quicklist";
        }

        {
          __unkeyed-1 = "<leader>q";
          mode = "n";
          group = "Quit/Session";
        }

      ];
    };
  };
}
