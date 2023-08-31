return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>fh", "<cmd>DiffviewFileHistory %<cr>", desc = "Open VCS File History" },
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    },
    opts = function(_, opts)
      local actions = require("diffview.actions")
      local new_opts = vim.tbl_extend("force", opts, {
        keymaps = {
          disable_defaults = true,
          -- stylua: ignore
          diff3 = {
            { { "n", "x" }, "<localleader>l", actions.diffget("ours"), { desc = "Obtain the diff hunk from the OURS version of the file" } },
            { { "n", "x" }, "<localleader>r", actions.diffget("theirs"), { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
            { "n", "g?", actions.help { "view", "diff3" }, { desc = "Open the help panel" } },
          },
          file_panel = {
            { "n", "g?", actions.help("file_panel"), { desc = "Open the help panel" } },
            { "n", "q", actions.close, { desc = "Close file panel" } },
            { "n", "h", actions.close_fold, { desc = "Collapse fold" } },
            { "n", "l", actions.select_entry, { desc = "Open the diff for the selected entry." } },
            { "n", "<cr>", "l", { remap = true, desc = "Open the diff for the selected entry." } },
            { "n", "<localleader>e", actions.goto_file_edit, { desc = "Open the file in the previous tabpage" } },
          },
          file_history_panel = {
            { "n", "g?", actions.help("file_history_panel"), { desc = "Open the help panel" } },
            { "n", "q", actions.close, { desc = "Close file history panel" } },
            { "n", "o", actions.select_entry, { desc = "Open the diff for the selected entry." } },
            { "n", "<cr>", "o", { remap = true, desc = "Open the diff for the selected entry." } },
          },
          help_panel = {
            { "n", "q", actions.close, { desc = "Close help menu" } },
          },
        },
      })
      return new_opts
    end,
  },
}
