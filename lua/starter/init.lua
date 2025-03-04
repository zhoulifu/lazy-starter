require("starter.globals")

local M = {}

local function lazy_init()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=v10.3.1",
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)
end

--- @param opts table
function M.setup(opts)
  local _opts = opts or {}
  local lazydefaults = {
    spec = {
      { "LazyVim/LazyVim", import = "lazyvim.plugins" },
      { import = "starter.plugins" },

      unpack(table.removekey(_opts, "spec") or {}),
    },
    lockfile = starter.path("lazy-lock.json"),
    defaults = {
      lazy = true,
    },
    ui = {
      border = "shadow",
      icons = {
        loaded = "✔ ",
        not_loaded = "✘ ",
      },
    },
    install = { colorscheme = { "catppuccin", "habamax" } },
    performance = {
      rtp = {
        reset = true,
        paths = { starter.path() },
        disabled_plugins = {
          "gzip",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  }

  lazy_init()
  require("lazy").setup(vim.tbl_deep_extend("force", lazydefaults, _opts or {}))
end

return M
