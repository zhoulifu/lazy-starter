local function is_http_file()
  return vim.bo.filetype == "http"
end

return {
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "http", "json" })
        end,
      },
      {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
          table.insert(opts.sections.lualine_x, 1, {
            function()
              return is_http_file() and vim.fn.fnamemodify(vim.b._rest_nvim_env_file, ":t") or ""
            end,
            icon = "",
            cond = is_http_file,
          })
        end,
      },
    },
    keys = {
      { "<f5>", "<cmd>Rest run<cr>", desc = "Run request under the cursor" },
      {
        "<f6>",
        function()
          require("rest-nvim.dotenv").select_file()
        end,
        desc = "Select env file",
      },
    },
    ft = "http",
  },
}
