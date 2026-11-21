-- zathura (PDF viewer) zathurarc. Option names from zathura/config.c.
-- Colors are quoted: zathurarc reads an unquoted "#" as a comment.
local Util = require("winteriscoming.util")

local M = {}

---@param c winteriscoming.ColorScheme
function M.generate(c)
  local function rgba(color, alpha)
    local v = Util.rgb(color)
    return ("rgba(%d,%d,%d,%s)"):format(v[1], v[2], v[3], alpha)
  end
  -- stylua: ignore
  local opts = {
    { "default-bg", c.bg },
    { "default-fg", c.fg },
    { "statusbar-bg", c.bg_dark },
    { "statusbar-fg", c.fg_dark },
    { "inputbar-bg", c.bg_dark },
    { "inputbar-fg", c.fg_light },
    { "completion-bg", c.bg_popup },
    { "completion-fg", c.fg_light },
    { "completion-group-bg", c.bg_popup },
    { "completion-group-fg", c.accent },
    { "completion-highlight-bg", c.bg_widget },
    { "completion-highlight-fg", c.fg_bright },
    { "notification-bg", c.bg_widget },
    { "notification-fg", c.fg_light },
    { "notification-error-bg", c.error },
    { "notification-error-fg", c.on_accent },
    { "notification-warning-bg", c.warning },
    { "notification-warning-fg", c.on_accent },
    { "index-bg", c.bg },
    { "index-fg", c.fg },
    { "index-active-bg", c.bg_widget },
    { "index-active-fg", c.fg_bright },
    { "scrollbar-bg", c.bg_dark },
    { "scrollbar-fg", c.bg_visual },
    { "render-loading-bg", c.bg },
    { "render-loading-fg", c.fg },
    -- recolor mode (:set recolor true) paints pages in the editor colors
    { "recolor-lightcolor", c.bg },
    { "recolor-darkcolor", c.fg },
    { "highlight-color", rgba(c.cream, 0.4) },
    { "highlight-active-color", rgba(c.ember, 0.5) },
    { "visual-caret-color", rgba(c.blue, 0.7) },
    { "signature-success-color", rgba(c.ok, 0.9) },
    { "signature-warning-color", rgba(c.warning, 0.9) },
    { "signature-error-color", rgba(c.error, 0.9) },
  }
  local out = {
    ("# %s for zathura: include this file from ~/.config/zathura/zathurarc"):format(c._style_name),
    "# upstream: " .. c._upstream_url,
    "",
  }
  for _, o in ipairs(opts) do
    out[#out + 1] = ('set %s "%s"'):format(o[1], o[2])
  end
  return table.concat(out, "\n") .. "\n"
end

return M
