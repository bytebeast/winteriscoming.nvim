local Util = require("winteriscoming.util")

local M = {}

---@param c winteriscoming.ColorScheme
function M.generate(c)
  return Util.template(
    [[
#!/usr/bin/env bash
# ${_style_name} for tmux: `source-file /path/to/this/file` in tmux.conf

set -g mode-style "fg=${fg_bright},bg=${bg_visual}"
set -g message-style "fg=${fg_light},bg=${bg_widget}"
set -g message-command-style "fg=${fg_light},bg=${bg_widget}"
set -g pane-border-style "fg=${border}"
set -g pane-active-border-style "fg=${blue}"

set -g status "on"
set -g status-justify "left"
set -g status-style "fg=${fg_dark},bg=${bg_dark}"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=${on_accent},bg=${blue},bold] #S #[fg=${fg_bright},bg=${bg_select}] #(whoami) #[fg=${fg_dark},bg=${bg_dark}] "
set -g status-right "#[fg=${fg_muted},bg=${bg_dark}] %Y-%m-%d #[fg=${fg_bright},bg=${bg_select}] %H:%M #[fg=${on_accent},bg=${blue},bold] #h "

setw -g window-status-activity-style "underscore,fg=${cream},bg=${bg_dark}"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=${fg_muted},bg=${bg_dark}"
setw -g window-status-format "#[fg=${fg_muted},bg=${bg_dark}] #I  #W #F "
setw -g window-status-current-format "#[fg=${fg_light},bg=${bg_widget},bold] #I  #W #F "

# tmux-plugins/tmux-prefix-highlight
set -g @prefix_highlight_output_prefix "#[fg=${cream}]#[bg=${bg_dark}]#[fg=${on_accent}]#[bg=${cream}]"
set -g @prefix_highlight_output_suffix ""
]],
    c
  )
end

return M
