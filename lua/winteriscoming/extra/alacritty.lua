local Util = require("winteriscoming.util")

local M = {}

---@param c winteriscoming.ColorScheme
function M.generate(c)
  return Util.template(
    [=[
# ${_style_name}
# upstream: ${_upstream_url}

[colors.primary]
background = "${bg}"
foreground = "${terminal.white}"

[colors.cursor]
cursor = "${blue}"
text = "${bg}"

[colors.selection]
background = "${bg_visual}"
text = "${fg_bright}"

[colors.search.matches]
background = "${bg_search}"
foreground = "${fg_bright}"

[colors.search.focused_match]
background = "${bg_cursearch}"
foreground = "${on_accent}"

[colors.footer_bar]
background = "${bg_dark}"
foreground = "${fg_dark}"

[colors.hints.start]
background = "${label}"
foreground = "${on_accent}"

[colors.hints.end]
background = "${bg_widget}"
foreground = "${label}"

[colors.normal]
black = "${terminal.black}"
red = "${terminal.red}"
green = "${terminal.green}"
yellow = "${terminal.yellow}"
blue = "${terminal.blue}"
magenta = "${terminal.magenta}"
cyan = "${terminal.cyan}"
white = "${terminal.white}"

[colors.bright]
black = "${terminal.black_bright}"
red = "${terminal.red_bright}"
green = "${terminal.green_bright}"
yellow = "${terminal.yellow_bright}"
blue = "${terminal.blue_bright}"
magenta = "${terminal.magenta_bright}"
cyan = "${terminal.cyan_bright}"
white = "${terminal.white_bright}"

[[colors.indexed_colors]]
index = 16
color = "${ember}"

[[colors.indexed_colors]]
index = 17
color = "${red_light}"
]=],
    c
  )
end

return M
