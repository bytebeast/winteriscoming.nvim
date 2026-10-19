local Util = require("winteriscoming.util")

local M = {}

---@param c winteriscoming.ColorScheme
function M.generate(c)
  return Util.template(
    [=[
# ${_style_name}
# upstream: ${_upstream_url}
# Copy to ~/.config/wezterm/colors/ and set `config.color_scheme = "${_style_name}"`
[colors]
foreground = "${terminal.white}"
background = "${bg}"
cursor_bg = "${blue}"
cursor_border = "${blue}"
cursor_fg = "${bg}"
selection_bg = "${bg_visual}"
selection_fg = "${fg_bright}"
split = "${border_highlight}"
compose_cursor = "${ember}"
scrollbar_thumb = "${bg_widget}"
ansi = ["${terminal.black}", "${terminal.red}", "${terminal.green}", "${terminal.yellow}", "${terminal.blue}", "${terminal.magenta}", "${terminal.cyan}", "${terminal.white}"]
brights = ["${terminal.black_bright}", "${terminal.red_bright}", "${terminal.green_bright}", "${terminal.yellow_bright}", "${terminal.blue_bright}", "${terminal.magenta_bright}", "${terminal.cyan_bright}", "${terminal.white_bright}"]

[colors.tab_bar]
inactive_tab_edge = "${bg_dark}"
background = "${bg_darker}"

[colors.tab_bar.active_tab]
fg_color = "${on_accent}"
bg_color = "${blue}"

[colors.tab_bar.inactive_tab]
fg_color = "${fg_muted}"
bg_color = "${bg_dark}"

[colors.tab_bar.inactive_tab_hover]
fg_color = "${fg_light}"
bg_color = "${bg_widget}"

[colors.tab_bar.new_tab]
fg_color = "${fg_muted}"
bg_color = "${bg_darker}"

[colors.tab_bar.new_tab_hover]
fg_color = "${blue}"
bg_color = "${bg_dark}"

[metadata]
aliases = []
author = "winteriscoming.nvim"
name = "${_style_name}"
]=],
    c
  )
end

return M
