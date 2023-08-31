require("lazyvim.util").on_load("nvim-dap", function()
  local dap = require("dap")
  -- stylua: ignore
  dap.listeners.before.event_initialized["dap_IDEA_keys"] = function()
    vim.keymap.set("n", "<f7>", function() dap.step_into() end, { desc = "Step Into" })
    vim.keymap.set("n", "<f8>", function() dap.step_over() end, { desc = "Step Over" })
    vim.keymap.set("n", "<s-f8>", function() dap.step_out() end, { desc = "Step Out" })
    vim.keymap.set("n", "<f9>", function() dap.continue() end, { desc = "Continue" })
    vim.keymap.set("n", "<s-f9>", function() dap.run_to_cursor() end, { desc = "Run To Cursor" })
  end
  dap.listeners.after.event_terminated["dap_IDEA_keys"] = function()
    vim.keymap.del("n", "<f7>")
    vim.keymap.del("n", "<f8>")
    vim.keymap.del("n", "<s-f8>")
    vim.keymap.del("n", "<f9>")
    vim.keymap.del("n", "<s-f9>")
  end
end)

return {
  { import = "lazyvim.plugins.extras.dap.core" },
}
