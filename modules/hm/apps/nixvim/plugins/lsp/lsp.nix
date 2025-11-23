{ lib, ... }:
{
  plugins = {
    lint.enable = true;
    lsp-signature.enable = true;
    lsp-lines.enable = true;

    lsp = {
      enable = true;
      inlayHints = true;

      servers = {
        vtsls.enable = true;
        tailwindcss.enable = true;
        jsonls.enable = true;
        html.enable = true;
        eslint.enable = true;
        cssls.enable = true;
      };
      onAttach = ''
        vim.keymap.del('n', 'grt')
        vim.keymap.del('n', 'gri')
        vim.keymap.del('n', 'grr')
        vim.keymap.del('n', 'gra')
        vim.keymap.del('n', 'grn')
      '';
      keymaps = {
        lspBuf = {
          # gd = {
          #   action = "definition";
          #   desc = "Goto Definition";
          # };
          # gr = {
          #   action = "references";
          #   desc = "Goto References";
          # };
          # gD = {
          #   action = "declaration";
          #   desc = "Goto Declaration";
          # };
          # gI = {
          #   action = "implementation";
          #   desc = "Goto Implementation";
          # };
          # gT = {
          #   action = "type_definition";
          #   desc = "Type Definition";
          # };
          K = {
            action = "hover";
            desc = "Hover";
          };
          "<leader>cr" = {
            action = "rename";
            desc = "Rename";
          };
          "<leader>ca" = {
            action = "code_action";
            desc = "Code Action";
          };
          "<C-k>" = {
            action = "signature_help";
            desc = "Signature Help";
          };
        };

        diagnostic = {
          "<leader>cd" = {
            action = "open_float";
            desc = "Line Diagnostics";
          };
          "]d" = {
            action = "goto_next";
            desc = "Next Diagnostic";
          };
          "[d" = {
            action = "goto_prev";
            desc = "Previous Diagnostic";
          };
        };
      };
    };
  };
}
