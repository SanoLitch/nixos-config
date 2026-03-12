{ pkgs, lib, ... }:
{
  plugins.neotest = {
    enable = true;
    adapters = {
      jest.enable = true;
      vitest.enable = true;
      playwright.enabke = true;
    };
    settings = {
      output = {
        enabled = true;
        open_on_run = true;
      };
      output_panel = {
        enabled = true;
        open = "botright split | resize 15";
      };
      quickfix = {
        enabled = true;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>tt";
      action = "<cmd>lua require('neotest').run.run()<cr>";
      options = {
        desc = "Run nearest test";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>tf";
      action = "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>";
      options = {
        desc = "Run current file";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>ts";
      action = "<cmd>lua require('neotest').summary.toggle()<cr>";
      options = {
        desc = "Toggle summary";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>to";
      action = "<cmd>lua require('neotest').output.open({ enter = true })<cr>";
      options = {
        desc = "Show output";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>tO";
      action = "<cmd>lua require('neotest').output_panel.toggle()<cr>";
      options = {
        desc = "Toggle output panel";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>tw";
      action = "<cmd>lua require('neotest').watch.toggle()<cr>";
      options = {
        desc = "Toggle watch mode";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>tx";
      action = "<cmd>lua require('neotest').run.stop()<cr>";
      options = {
        desc = "Stop test run";
        silent = true;
      };
    }
  ];
}

