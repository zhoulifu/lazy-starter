local M = {}

local group_prefix = "_starter_"

function M.augroup(name)
  return vim.api.nvim_create_augroup(group_prefix .. name, { clear = true })
end

--- @param keymaps table
--- @param action function
function M.on_plugins_ft(keymaps, action)
  local km = keymaps or {}

  --- @param plugin LazyPlugin
  return function(plugin)
    if not plugin.ft then
      return
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = M.augroup(plugin.name .. "_pluginft"),
      pattern = plugin.ft,
      callback = function()
        if action then
          action()
        end

        for _, keymap in ipairs(km) do
          vim.keymap.set(keymap[1], keymap[2], keymap[3], vim.tbl_extend("force", keymap[4], { buffer = true }))
        end
      end,
    })
  end
end

-- See also: ~
--   • |nvim_create_autocmd()|
--- @param events object
--- @param opts? table<string, any>
function M.au_on_plugin_init(events, opts)
  --- @param plugin LazyPlugin
  return function(plugin)
    vim.api.nvim_create_autocmd(events, vim.tbl_extend("force", opts, { group = M.augroup(plugin.name .. "_initau") }))
  end
end

return M
