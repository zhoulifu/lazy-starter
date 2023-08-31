return {
  { "folke/neoconf.nvim", enabled = false },

  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        ["*"] = function()
          return _G.lsp_disabled
        end,
      },
    },
  },
}
