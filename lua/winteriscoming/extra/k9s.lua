-- k9s skin (https://k9scli.io/topics/skins/). Keys follow k9s's Style structs
-- (internal/config/styles.go); the test suite checks every key against them.
-- Variants: "default" paints the theme backgrounds, "transparent" uses the
-- terminal's own background ("default" is k9s's terminal-default color).
local M = {}

---@param c winteriscoming.ColorScheme
---@param variant "default"|"transparent"
function M.generate(c, variant)
  local t = vim.deepcopy(c)
  local clear = variant == "transparent"
  t._bg = clear and "default" or c.bg
  t._bg_alt = clear and "default" or c.bg_dark
  t._variant = clear and " (transparent)" or ""
  t._skin = c._name .. (clear and "_transparent" or "")
  -- k9s inverts the selected row: its background becomes the row's status
  -- color (fg, blue, green, red, ...) and its text uses cursorFgColor, so the
  -- cursor text must be the background tone that contrasts most with all of them.
  t._cursor_fg = c.is_light and c.bg or c.bg_darker
  return require("winteriscoming.util").template(
    [[
# ${_style_name}${_variant} for k9s
# upstream: ${_upstream_url}
# Copy to the k9s skins directory, then set `k9s.ui.skin: ${_skin}`
# in k9s's config.yaml.
#   Linux:  ~/.config/k9s/skins/
#   macOS:  ~/Library/Application Support/k9s/skins/
#   or run `k9s info` to print the skins directory k9s actually uses

k9s:
  body:
    fgColor: "${fg}"
    bgColor: "${_bg}"
    logoColor: "${purple}"
    logoColorMsg: "${fg}"
    logoColorInfo: "${blue}"
    logoColorWarn: "${gold}"
    logoColorError: "${red}"
  prompt:
    fgColor: "${fg}"
    bgColor: "${_bg_alt}"
    suggestColor: "${comment}"
    border:
      command: "${blue}"
      default: "${teal}"
  help:
    fgColor: "${fg}"
    bgColor: "${_bg}"
    sectionColor: "${green}"
    keyColor: "${blue}"
    numKeyColor: "${ember}"
  frame:
    title:
      fgColor: "${blue}"
      bgColor: "${_bg}"
      highlightColor: "${pink}"
      counterColor: "${gold}"
      filterColor: "${green}"
    border:
      fgColor: "${border}"
      focusColor: "${blue}"
    menu:
      fgColor: "${fg_dark}"
      keyColor: "${blue}"
      numKeyColor: "${ember}"
    crumbs:
      fgColor: "${on_accent}"
      bgColor: "${lavender}"
      activeColor: "${blue}"
    status:
      newColor: "${blue}"
      modifyColor: "${lavender}"
      addColor: "${green}"
      pendingColor: "${ember}"
      errorColor: "${red}"
      highlightColor: "${cyan}"
      killColor: "${purple}"
      completedColor: "${comment}"
  info:
    fgColor: "${ember}"
    sectionColor: "${fg}"
    cpuColor: "${purple}"
    memColor: "${gold}"
    k9sRevColor: "${green}"
  views:
    table:
      fgColor: "${fg}"
      bgColor: "${_bg}"
      cursorFgColor: "${_cursor_fg}"
      cursorBgColor: "${fg}"
      markColor: "${pink}"
      header:
        fgColor: "${gold}"
        bgColor: "${_bg}"
        sorterColor: "${cyan}"
        selectedSortColumnColor: "${ember}"
    xray:
      fgColor: "${fg}"
      bgColor: "${_bg}"
      cursorColor: "${blue}"
      cursorTextColor: "${_cursor_fg}"
      graphicColor: "${purple}"
    charts:
      bgColor: "${_bg}"
      chartBgColor: "${_bg}"
      dialBgColor: "${_bg}"
      focusFgColor: "${fg}"
      focusBgColor: "${bg_widget}"
      defaultDialColors:
        - "${green}"
        - "${red}"
      defaultChartColors:
        - "${green}"
        - "${red}"
      resourceColors:
        cpu:
          - "${purple}"
          - "${blue}"
        mem:
          - "${gold}"
          - "${ember}"
    yaml:
      keyColor: "${teal}"
      valueColor: "${fg}"
      colonColor: "${fg_dark}"
    picker:
      mainColor: "${fg}"
      focusColor: "${blue}"
      shortcutColor: "${ember}"
    logs:
      fgColor: "${fg}"
      bgColor: "${_bg}"
      indicator:
        fgColor: "${lavender}"
        bgColor: "${_bg}"
        toggleOnColor: "${green}"
        toggleOffColor: "${comment}"
  dialog:
    fgColor: "${fg}"
    bgColor: "${_bg_alt}"
    buttonFgColor: "${fg}"
    buttonBgColor: "${bg_widget}"
    buttonFocusFgColor: "${on_accent}"
    buttonFocusBgColor: "${blue}"
    labelFgColor: "${ember}"
    fieldFgColor: "${fg}"
]],
    t
  )
end

return M
