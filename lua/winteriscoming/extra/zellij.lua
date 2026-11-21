-- zellij theme in the named-style spec (zellij 0.42+): every style in
-- zellij-utils THEME_STYLES with all six components, plus the multiplayer
-- colors. RGB triplets, like zellij's bundled themes.
local Util = require("winteriscoming.util")

local M = {}

-- Style names in the order zellij lists them (zellij-utils/src/kdl/mod.rs).
-- stylua: ignore
M.styles = {
  "text_unselected", "text_selected", "ribbon_unselected", "ribbon_selected", "ribbon_hover",
  "table_title", "table_cell_unselected", "table_cell_selected", "list_unselected", "list_selected",
  "frame_unselected", "frame_selected", "frame_highlight", "exit_code_success", "exit_code_error",
}

---@param c winteriscoming.ColorScheme
function M.generate(c)
  local function rgb(color)
    local v = Util.rgb(color)
    return ("%d %d %d"):format(v[1], v[2], v[3])
  end
  -- emphasis_0..3 mark keys and matches; on badges they're pulled toward the
  -- badge text until they read at 4.5:1
  local function style(base, bg, toward)
    local out = { base = base, background = bg }
    for i, color in ipairs({ c.cream, c.ice, c.green, c.pink }) do
      out["emphasis_" .. (i - 1)] = Util.ensure_contrast(color, bg, 4.5, toward or c.fg)
    end
    return out
  end
  local unselected = style(c.fg_light, c.bg_dark)
  local selected = style(c.fg_bright, c.bg_widget)
  local defs = {
    text_unselected = unselected,
    text_selected = selected,
    ribbon_unselected = style(Util.ensure_contrast(c.fg_dark, c.bg_highlight, 4.5, c.fg), c.bg_highlight),
    ribbon_selected = style(c.on_accent, c.accent, c.on_accent),
    ribbon_hover = style(c.fg_light, c.bg_widget),
    table_title = style(c.accent, c.bg_dark),
    table_cell_unselected = unselected,
    table_cell_selected = selected,
    list_unselected = unselected,
    list_selected = selected,
    frame_unselected = style(c.border, c.bg),
    frame_selected = style(c.accent, c.bg),
    frame_highlight = style(c.cream, c.bg),
    exit_code_success = style(c.ok, c.bg),
    exit_code_error = style(c.error, c.bg),
  }
  local out = {
    ("// %s for zellij"):format(c._style_name),
    "// upstream: " .. c._upstream_url,
    ('// Copy to ~/.config/zellij/themes/, then set `theme "%s"`'):format(c._name),
    "themes {",
    ("    %s {"):format(c._name),
  }
  for _, name in ipairs(M.styles) do
    local d = defs[name]
    out[#out + 1] = ("        %s {"):format(name)
    for _, k in ipairs({ "base", "background", "emphasis_0", "emphasis_1", "emphasis_2", "emphasis_3" }) do
      out[#out + 1] = ("            %s %s"):format(k, rgb(d[k]))
    end
    out[#out + 1] = "        }"
  end
  out[#out + 1] = "        multiplayer_user_colors {"
  local players = { c.pink, c.blue, c.ember, c.cream, c.sky, c.green, c.red, c.lavender, c.teal, c.purple }
  for i, color in ipairs(players) do
    out[#out + 1] = ("            player_%d %s"):format(i, rgb(color))
  end
  out[#out + 1] = "        }"
  out[#out + 1] = "    }"
  out[#out + 1] = "}"
  return table.concat(out, "\n") .. "\n"
end

return M
