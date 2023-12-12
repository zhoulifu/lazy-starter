return {
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "fade",
    },
  },

  { "lukas-reineke/indent-blankline.nvim", enabled = false },

  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = {
        animation = function()
          return 5
        end,
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        groups = {
          items = {
            require("bufferline.groups").builtin.pinned:with { icon = "" },
          },
        },
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
