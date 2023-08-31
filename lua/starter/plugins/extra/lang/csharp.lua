local extented_package_names = {
  ["csharp_ls"] = "csharpls",
  ["omnisharp"] = "omnisharp",
}

local keys = {
  { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Goto Definition" },
}

local function server_setup(server, opts)
  ---@diagnostic disable-next-line: undefined-field
  local preferred_server = _G.csharp_language_server_name or "omnisharp"

  if _G.lsp_disabled or server ~= preferred_server then
    -- return true to disable lspconfig setup
    return true
  end

  opts.root_dir = require("lspconfig.util").root_pattern("*.sln", ".git")
  opts.handlers = {
    ["textDocument/definition"] = require(extented_package_names[server] .. "_extended").handler,
  }
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "Decodetalkers/csharpls-extended-lsp.nvim",
      "Hoffs/omnisharp-extended-lsp.nvim",
    },
    opts = {
      servers = {
        csharp_ls = {
          keys = keys,
        },
        omnisharp = {
          keys = keys,
        },
      },
      setup = {
        csharp_ls = server_setup,
        omnisharp = server_setup,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "c_sharp" })
      opts.context_commentstring.config.c_sharp = { __default = "// %s", __multiline = "/* %s */" }
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      local default_icons = require("nvim-web-devicons").get_icons()
      default_icons["sdmap"] = default_icons["sql"]
      default_icons["csproj"] = default_icons["xml"]
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "coreclr" })
      opts.handlers = {
        coreclr = function(cfg)
          cfg.configurations = {
            {
              type = "coreclr",
              name = "launch - netcoredbg",
              request = "launch",
              args = { "--urls", "http://localhost:8080", "https://localhost:8443" },
              env = {
                ["ASPNETCORE_ENVIRONMENT"] = "Development",
              },
            },
          }
          require("mason-nvim-dap").default_setup(cfg)

          for _, c in ipairs(require("dap").configurations["cs"]) do
            setmetatable(c, {
              __call = function(_cfg, _)
                _cfg.cwd = vim.fn.input {
                  prompt = "Select project: ",
                  default = starter.current_workspace() .. "/",
                  completion = "dir",
                }
                _cfg.program = vim.fn.input {
                  prompt = "Path to dll: ",
                  default = _cfg.cwd .. "bin/Debug/",
                  completion = "file",
                }
                return _cfg
              end,
            })
          end
        end,
      }
    end,
  },
}
