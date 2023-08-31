local env_file_name = ".restnvim.env"
local workspace = vim.fn.stdpath("data")

local function on_plugin_init(plugin)
  local group = require("starter.util.lazy_extensions").augroup(plugin.name .. "init")

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = plugin.ft,
    callback = function()
      vim.api.nvim_buf_set_keymap(0, "n", "<f5>", "<plug>RestNvim", { desc = "Run request under cursor" })
      vim.api.nvim_buf_set_keymap(0, "n", "<f6>", "<plug>RestNvimPreview", { desc = "Preview request cURL command" })
      -- stylua: ignore
      vim.api.nvim_buf_set_keymap(0, "n", "<f7>", "<cmd>sp " .. workspace .. "/" .. env_file_name .. "<cr>", { desc = "View request env" })
    end,
  })

  vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    pattern = "*.http",
    callback = function()
      local prev_dir = vim.fn.chdir(workspace)
      if prev_dir ~= workspace then
        vim.api.nvim_create_autocmd("BufLeave", {
          once = true,
          pattern = "<buffer>",
          callback = function()
            vim.fn.chdir(prev_dir)
          end,
        })
      end
    end,
  })
end

return {
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      env_file = env_file_name,
    },
    ft = "http",
    init = on_plugin_init,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "http", "json" })
    end,
  },
}
