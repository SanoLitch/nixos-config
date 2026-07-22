{ ... }:
{
  plugins.minuet = {
    enable = true;
    settings = {
      # cmp = {
      #   enable_auto_complete = true;
      # };
      # blink = {
      #   enable_auto_complete = true;
      # };
      # lsp = {
      #   enabled_ft = [
      #     "javascript"
      #     "typescript"
      #     "javascriptreact"
      #     "typescriptreact"
      #     "rust"
      #   ];
      #   # completion = {
      #   #   enable = true;
      #   #   warn_on_blink_or_cmp = true;
      #   #   adjust_indentation = true;
      #   # };
      # };
      virtualtext = {
        auto_trigger_ft = [
          # "javascript"
          # "typescript"
          # "javascriptreact"
          # "typescriptreact"
          # "rust"
          # "nix"
          # "bash"
          # "markdown"
          # "json"
          # "yaml"
          # "toml"
          # "groovy"
        ];
        keymap = {
          accept = "<A-A>";
          accept_line = "<A-a>";
          accept_n_lines = "<A-z>";
          prev = "<A-[>";
          next = "<A-]>";
          dismiss = "<A-e>";
        };
      };

      throttle = 1500;
      debounce = 1000;
      request_timeout = 3;
      n_complitions = 3;
      context_window = 256;

      provider = "openai_fim_compatible";
      provider_options = {
        openai_fim_compatible = {
          name = "Ollama";
          api_key = "TERM";
          end_point = "http://192.168.1.10:11434/v1/completions";
          model = "qwen2.5-coder:1.5b";
          optional = {
            max_tokens = 56;
            top_p = 0.9;
          };
          stream = false;
        };
      };
    };
  };
}
