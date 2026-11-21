-- Yazi flavors: one winteriscoming-<style>.yazi/ folder per style, as yazi loads
-- them (flavors/<name>.yazi/flavor.toml + tmtheme.xml, yazi-config
-- src/theme/flavor.rs). Keys follow yazi's preset theme (theme-dark.toml);
-- tmtheme.xml is the bat theme, so previews highlight code the same way.
local M = {}

---@param c winteriscoming.ColorScheme
function M.generate(c)
  local g, on = c.git, c.on_accent
  local sel = require("winteriscoming.util").blend_bg(c.blue, c.is_light and 0.2 or 0.3) -- PmenuSel
  local function fg(color, extra)
    return ('{ fg = "%s"%s }'):format(color, extra or "")
  end
  local function badge(bg)
    return ('{ fg = "%s", bg = "%s", bold = true }'):format(on, bg)
  end
  local function alt(color)
    return ('{ fg = "%s", bg = "%s" }'):format(color, c.bg_widget)
  end
  local function marker(color)
    return ('{ fg = "%s", bg = "%s" }'):format(color, color)
  end
  local border = fg(c.border_highlight)
  -- stylua: ignore
  local sections = {
    { "mgr", {
      { "cwd", fg(c.sky) },
      { "find_keyword", fg(c.cream, ", bold = true, italic = true, underline = true") },
      { "find_position", fg(c.ice, ', bg = "reset", bold = true, italic = true') },
      { "symlink_target", fg(c.teal, ", italic = true") },
      { "marker_copied", marker(g.add) },
      { "marker_cut", marker(g.delete) },
      { "marker_marked", marker(c.teal) },
      { "marker_selected", marker(c.cream) },
      { "count_copied", badge(g.add) },
      { "count_cut", badge(g.delete) },
      { "count_selected", badge(c.cream) },
      { "border_style", fg(c.border) },
    } },
    { "tabs", {
      { "active", badge(c.accent) },
      { "inactive", ('{ fg = "%s", bg = "%s" }'):format(c.fg_muted, c.bg_dark) },
    } },
    { "mode", {
      { "normal_main", badge(c.modes.normal) }, { "normal_alt", alt(c.modes.normal) },
      { "select_main", badge(c.modes.visual) }, { "select_alt", alt(c.modes.visual) },
      { "unset_main", badge(c.modes.replace) }, { "unset_alt", alt(c.modes.replace) },
    } },
    { "indicator", {
      { "current", ('{ bg = "%s", bold = true }'):format(sel) },
    } },
    { "status", {
      { "perm_sep", fg(c.fg_muted) },
      { "perm_type", fg(c.sky) },
      { "perm_read", fg(c.gold) },
      { "perm_write", fg(c.red) },
      { "perm_exec", fg(c.green) },
      { "progress_label", fg(c.fg, ", bold = true") },
      { "progress_normal", ('{ fg = "%s", bg = "%s" }'):format(c.accent, c.bg_widget) },
      { "progress_error", ('{ fg = "%s", bg = "%s" }'):format(c.error, c.bg_widget) },
    } },
    { "which", {
      { "border", border },
      { "mask", ('{ bg = "%s" }'):format(c.bg_float) },
      { "cand", fg(c.ice) },
      { "rest", fg(c.fg_muted) },
      { "desc", fg(c.purple) },
      { "separator_style", fg(c.fg_muted) },
    } },
    { "confirm", {
      { "border", border },
      { "title", fg(c.accent, ", bold = true") },
      { "btn_yes", badge(c.accent) },
      { "btn_no", fg(c.fg_dark) },
    } },
    { "spot", {
      { "border", border },
      { "title", fg(c.accent, ", bold = true") },
      { "tbl_col", fg(c.sky) },
      { "tbl_cell", ('{ bg = "%s" }'):format(sel) },
    } },
    { "notify", {
      { "title_info", fg(c.info) },
      { "title_warn", fg(c.warning) },
      { "title_error", fg(c.error) },
    } },
    { "pick", { { "border", border }, { "active", fg(c.accent, ", bold = true") } } },
    { "input", {
      { "border", border },
      { "title", fg(c.accent) },
      { "value", fg(c.fg) },
      { "hint", fg(c.fg_muted, ", italic = true") },
      { "selected", ('{ bg = "%s" }'):format(c.bg_visual) },
    } },
    { "cmp", { { "border", border }, { "active", ('{ bg = "%s", bold = true }'):format(sel) } } },
    { "tasks", { { "border", border }, { "title", fg(c.accent) }, { "hovered", fg(c.accent, ", bold = true") } } },
    { "help", {
      { "border", border },
      { "chord", fg(c.ice) },
      { "hovered", ('{ bg = "%s", bold = true }'):format(sel) },
    } },
  }
  local out = { ("# %s: %s"):format(c._style_name, c._upstream_url) }
  for _, section in ipairs(sections) do
    out[#out + 1] = ""
    out[#out + 1] = ("[%s]"):format(section[1])
    for _, kv in ipairs(section[2]) do
      out[#out + 1] = ("%s = %s"):format(kv[1], kv[2])
    end
  end
  -- stylua: ignore
  local rules = {
    ('{ mime = "**/image/*", fg = "%s" }'):format(c.cream),
    ('{ mime = "**/{audio,video}/*", fg = "%s" }'):format(c.purple),
    ('{ mime = "**/application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}", fg = "%s" }'):format(c.red),
    ('{ mime = "**/application/{pdf,doc,rtf}", fg = "%s" }'):format(c.teal),
    ('{ mime = "vfs/{absent,stale}", fg = "%s" }'):format(c.fg_muted),
    ('{ url = "*", is = "orphan", fg = "%s" }'):format(c.error),
    ('{ url = "*", is = "exec", fg = "%s" }'):format(c.green),
    ('{ url = "*", is = "dummy", fg = "%s" }'):format(c.error),
    ('{ url = "*/", is = "dummy", fg = "%s" }'):format(c.error),
    ('{ url = "*", fg = "%s" }'):format(c.fg),
    ('{ url = "*/", fg = "%s" }'):format(c.sky),
  }
  out[#out + 1] = ""
  out[#out + 1] = "[filetype]"
  out[#out + 1] = "rules = ["
  for _, rule in ipairs(rules) do
    out[#out + 1] = "\t" .. rule .. ","
  end
  out[#out + 1] = "]"
  return table.concat(out, "\n") .. "\n"
end

--- One flavor folder per style.
function M.static()
  local Extras = require("winteriscoming.extra")
  local files = {}
  for _, style in ipairs(require("winteriscoming.config").styles) do
    local dir = "winteriscoming-" .. style .. ".yazi/"
    files[dir .. "flavor.toml"] = Extras.render("yazi", style)
    files[dir .. "tmtheme.xml"] = Extras.render("bat", style)
  end
  return files
end

return M
