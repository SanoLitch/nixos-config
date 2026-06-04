{ lib, ... }:
# let
#   inherit (lib.nixvim) mkRaw;
# in
{
  plugins = {
    luasnip.enable = true;
    blink-cmp = {
      enable = true;
      sources = {
        default = [
          "lsp"
          "path"
          "buffer"
          "snippets"
          "minuet"
        ];
        # cmdline = [ ];
        # providers = {
        #   # buffer = {
        #   #   score_offset = -7;
        #   # };
        #   # lsp = {
        #   #   fallbacks = [ ];
        #   # };
        #   minuet = {
        #     name = "minuet";
        #     module = "minuet.blink";
        #     async = true;
        #     timeout_ms = 3000;
        #     score_offset = 50;
        #   };
        # };
      };
      completion = {
        trigger = {
          prefetch_on_insert = false;
        };
      };

      settings = {
        completion.menu.border = "rounded";
        keymap = {
          "<C-j>" = [
            "select_next"
            "fallback"
          ];
          "<C-k>" = [
            "select_prev"
            "fallback"
          ];
          #
          # "<c-l>" = [
          #   "snippet_forward"
          #   "fallback"
          # ];
          # "<c-h>" = [
          #   "snippet_backward"
          #   "fallback"
          # ];
          "<C-u>" = [
            "scroll_documentation_up"
            "fallback"
          ];
          "<C-d>" = [
            "scroll_documentation_down"
            "fallback"
          ];
          "<CR>" = [
            "select_and_accept"
            "fallback"
          ];
          "<Tab>" = [
            "select_and_accept"
            "fallback"
          ];
          # "<C-space>" = [
          #   (
          #     # lua
          #     mkRaw ''
          #       function(cmp)
          #         local ok,_ = pcall(require, "copilot")
          #           if ok then
          #             vim.g.copilot_no_tab_map = true
          #             vim.g.copilot_assume_mapped = true
          #             vim.g.copilot_tab_fallback = ""
          #
          #             local suggestion = require("copilot.suggestion")
          #             if suggestion.is_visible() then
          #               suggestion.accept()
          #             else
          #               if cmp.snippet_active() then
          #               return cmp.select_and_accept()
          #               else
          #               return cmp.accept()
          #               end
          #             end
          #           end
          #         end
          #     ''
          #   )
          # ];
        };
      };
    };
  };
}
