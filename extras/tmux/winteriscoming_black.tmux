#!/usr/bin/env bash
# Winter is Coming Dark Black for tmux: `source-file /path/to/this/file` in tmux.conf

set -g mode-style "fg=#eeefff,bg=#2a4258"
set -g message-style "fg=#d6deeb,bg=#33332c"
set -g message-command-style "fg=#d6deeb,bg=#33332c"
set -g pane-border-style "fg=#3a3a32"
set -g pane-active-border-style "fg=#219fd5"

set -g status "on"
set -g status-justify "left"
set -g status-style "fg=#7799bb,bg=#1f1f1a"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#171713,bg=#219fd5,bold] #S #[fg=#eeefff,bg=#4f4f4f] #(whoami) #[fg=#7799bb,bg=#1f1f1a] "
set -g status-right "#[fg=#5f7e97,bg=#1f1f1a] %Y-%m-%d #[fg=#eeefff,bg=#4f4f4f] %H:%M #[fg=#171713,bg=#219fd5,bold] #h "

setw -g window-status-activity-style "underscore,fg=#f7ecb5,bg=#1f1f1a"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#5f7e97,bg=#1f1f1a"
setw -g window-status-format "#[fg=#5f7e97,bg=#1f1f1a] #I  #W #F "
setw -g window-status-current-format "#[fg=#d6deeb,bg=#33332c,bold] #I  #W #F "

# tmux-plugins/tmux-prefix-highlight
set -g @prefix_highlight_output_prefix "#[fg=#f7ecb5]#[bg=#1f1f1a]#[fg=#171713]#[bg=#f7ecb5]"
set -g @prefix_highlight_output_suffix ""
