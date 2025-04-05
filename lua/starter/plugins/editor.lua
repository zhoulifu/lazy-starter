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

  {
    "saghen/blink.cmp",
    opts = {
      keymap = { preset = "super-tab" },
    },
  },
}
