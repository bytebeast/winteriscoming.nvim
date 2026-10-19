local Util = require("winteriscoming.util")

local M = {}

---@param c winteriscoming.ColorScheme
function M.generate(c)
  return Util.template(
    [[
# vim:ft=kitty
## name: ${_style_name}
## upstream: ${_upstream_url}

background ${bg}
foreground ${terminal.white}
selection_background ${bg_visual}
selection_foreground ${fg_bright}
url_color ${aqua}
cursor ${blue}
cursor_text_color ${bg}

# Tabs
active_tab_background ${blue}
active_tab_foreground ${on_accent}
inactive_tab_background ${bg_dark}
inactive_tab_foreground ${fg_muted}
tab_bar_background ${bg_darker}

# Windows
active_border_color ${blue}
inactive_border_color ${border}

# normal
color0 ${terminal.black}
color1 ${terminal.red}
color2 ${terminal.green}
color3 ${terminal.yellow}
color4 ${terminal.blue}
color5 ${terminal.magenta}
color6 ${terminal.cyan}
color7 ${terminal.white}

# bright
color8 ${terminal.black_bright}
color9 ${terminal.red_bright}
color10 ${terminal.green_bright}
color11 ${terminal.yellow_bright}
color12 ${terminal.blue_bright}
color13 ${terminal.magenta_bright}
color14 ${terminal.cyan_bright}
color15 ${terminal.white_bright}

# extended colors
color16 ${ember}
color17 ${red_light}
]],
    c
  )
end

return M
