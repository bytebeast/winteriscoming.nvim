#!/usr/bin/env bash
# Winter is Coming Dark Blue for tmux: `source-file /path/to/this/file` in tmux.conf

set -g mode-style "fg=#eeefff,bg=#103362"
set -g message-style "fg=#d6deeb,bg=#0b2942"
set -g message-command-style "fg=#d6deeb,bg=#0b2942"
set -g pane-border-style "fg=#122d42"
set -g pane-active-border-style "fg=#219fd5"

set -g status "on"
set -g status-justify "left"
set -g status-style "fg=#7799bb,bg=#010e1a"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#000a11,bg=#219fd5,bold] #S #[fg=#eeefff,bg=#03648a] #(whoami) #[fg=#7799bb,bg=#010e1a] "
set -g status-right "#[fg=#5f7e97,bg=#010e1a] %Y-%m-%d #[fg=#eeefff,bg=#03648a] %H:%M #[fg=#000a11,bg=#219fd5,bold] #h "

setw -g window-status-activity-style "underscore,fg=#f7ecb5,bg=#010e1a"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#5f7e97,bg=#010e1a"
setw -g window-status-format "#[fg=#5f7e97,bg=#010e1a] #I  #W #F "
setw -g window-status-current-format "#[fg=#d6deeb,bg=#0b2942,bold] #I  #W #F "

# tmux-plugins/tmux-prefix-highlight
set -g @prefix_highlight_output_prefix "#[fg=#f7ecb5]#[bg=#010e1a]#[fg=#000a11]#[bg=#f7ecb5]"
set -g @prefix_highlight_output_suffix ""
