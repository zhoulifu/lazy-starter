return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      default_component_configs = {
        file_size = { enabled = false },
        type = { enabled = false },
        last_modified = { enabled = false },
        created = { enabled = false },
      },
    },
    keys = function()
      return {
        {
          "<leader>e",
          function()
            require("neo-tree.command").execute { toggle = true, dir = starter.current_workspace() }
          end,
          desc = "Explorer NeoTree (root dir)",
        },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "JoosepAlviste/nvim-ts-context-commentstring" },
    },
    opts = {
      context_commentstring = {
        enable = true,
        config = {},
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      attach_to_untracked = false,
    },
  },

  {
    "folke/flash.nvim",
    opts = {
      modes = {
        search = {
          search = {
            trigger = ";",
          },
        },
        char = {
          multi_line = false,
          highlight = { backdrop = false },
        },
      },
      label = { after = false, before = true },
      highlight = {
        groups = {
          label = "Folded",
        },
      },
    },
  },
}
