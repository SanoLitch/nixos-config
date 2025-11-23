{
  keymaps = [
    {
      mode = "n";
      key = "<S-h>";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options = {
        desc = "Cycle to next buffer";
      };
    }

    {
      mode = "n";
      key = "<S-l>";
      action = "<cmd>BufferLineCycleNext<cr>";
      options = {
        desc = "Cycle to next buffer";
      };
    }

    {
      mode = "n";
      key = "<C-x>";
      action = "<cmd>lua Snacks.bufdelete.delete()<cr>";
      options.desc = "Close buffer";
    }

    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>lua Snacks.bufdelete.delete()<cr>";
      options.desc = "Close buffer";
    }

    {
      mode = "n";
      key = "<leader>bo";
      action = "<cmd>BufferLineCloseOther<cr>";
      options = {
        desc = "Buffer close all except the current buffer";
      };
    }
  ];
}
