return {
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      opts.options.groups = {
        items = {
          require("bufferline.groups").builtin.pinned:with { icon = "" },
        },
      }

      if (vim.g.colors_name or ""):find("catppuccin") then
        opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
      end
    end,
  },

  {
    "LazyVim/LazyVim",
    dependencies = {
      "catppuccin/nvim",
      opts = {
        background = {
          dark = "frappe",
        },
      },
    },
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
