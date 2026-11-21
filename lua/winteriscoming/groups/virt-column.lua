local M = {}

M.url = "https://github.com/lukas-reineke/virt-column.nvim"

-- A thin line the color of indent guides. virt-column's own default draws
-- with `NonText`; set `highlight = "VirtColumn"` to use this group.

---@param c winteriscoming.ColorScheme
---@param opts winteriscoming.Config
function M.get(c, opts)
  return {
    VirtColumn = { fg = c.fg_gutter },
  }
end

return M
