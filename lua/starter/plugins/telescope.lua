local telescope = require("lazyvim.util").telescope
local Themes = require("telescope.themes")
local ClassSymbols = { "Class", "Enum", "Interface", "Struct", "Trait" }
local OtherSymbols = { "Method", "Property", "Field", "Constructor", "Function", "Constant" }

local themes = {
  cursor = function(opts)
    opts =
      vim.tbl_deep_extend("force", opts or {}, { layout_config = { height = 0.5, width = 0.8, preview_cutoff = 120 } })
    return Themes.get_cursor(opts)
  end,

  dropdown = function(opts)
    opts =
      vim.tbl_deep_extend("force", opts or {}, { previewer = false, layout_config = { height = 0.7, width = 0.8 } })
    return Themes.get_dropdown(opts)
  end,

  symbols = function(opts)
    opts = vim.tbl_deep_extend("force", opts or {}, {
      previewer = false,
      layout_config = { height = 0.6, width = 0.6 },
      symbol_width = 120,
      path_display = { "hidden" },
    })
    return Themes.get_dropdown(opts)
  end,
}

local function disabled_telescope_keys()
  local keys = {
    "<leader>fF", -- Find Files (cwd)
    "<leader>fR", -- Recent (cwd)
    "<leader>sC", -- Commands
    "<leader>sg", -- Grep (root dir)
    "<leader>sG", -- Grep (cwd)
    "<leader>sh", -- Help Pages
    "<leader>sM", -- Man Pages
    "<leader>sW", -- Word (cwd)
  }

  local disabled = {}
  for _, key in ipairs(keys) do
    table.insert(disabled, { key, false })
  end

  return disabled
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-telescope/telescope-dap.nvim",
    },
    opts = {
      defaults = {
        scroll_strategy = "limit",
        wrap_results = true,
      },
      pickers = {
        lsp_references = themes.cursor { include_declaration = false, show_line = false },
        lsp_implementations = themes.cursor { show_line = false },
        git_files = themes.dropdown(),
        find_files = themes.dropdown(),
      },
    },
    config = function(_, opts)
      local pkg = require("telescope")
      pkg.setup(opts)
      pkg.load_extension("dap")
      pkg.load_extension("notify")
    end,
    keys = {
      {
        "<leader>sc",
        telescope("lsp_dynamic_workspace_symbols", themes.symbols { prompt_title = "Classes", symbols = ClassSymbols }),
        desc = "Goto Class",
      },
      {
        "<leader>ss",
        telescope("lsp_dynamic_workspace_symbols", themes.symbols { prompt_title = "Symbols", symbols = OtherSymbols }),
        desc = "Goto Symbol (Workspace)",
      },
      {
        "<leader>sS",
        telescope(
          "lsp_document_symbols",
          themes.symbols {
            prompt_title = "Document Symbols",
            symbols = vim.tbl_flatten { ClassSymbols, OtherSymbols },
          }
        ),
        desc = "Goto Symbol (Document)",
      },
      unpack(disabled_telescope_keys()),
    },
  },
}
