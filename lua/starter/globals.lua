local _path

_G.lsp_disabled = false
_G.starter = {
  path = function(relative)
    if not _path then
      local src = debug.getinfo(1, "S").source:sub(2)
      _path = vim.fn.fnamemodify(src, ":p:h:h:h")
    end
    return relative == nil and _path or _path .. "/" .. relative
  end,

  current_workspace = function()
    return require("lazyvim.util").get_root()
  end,
}

function table.removekey(tb, key)
  local val = tb[key]
  tb[key] = nil
  return val
end
