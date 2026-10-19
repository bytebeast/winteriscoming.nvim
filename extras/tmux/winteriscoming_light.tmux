#!/usr/bin/env bash
# Winter is Coming Light for tmux: `source-file /path/to/this/file` in tmux.conf

set -g mode-style "fg=#011627,bg=#cee1f0"
set -g message-style "fg=#3e3e3e,bg=#e3e3e3"
set -g message-command-style "fg=#3e3e3e,bg=#e3e3e3"
set -g pane-border-style "fg=#d4d4d4"
set -g pane-active-border-style "fg=#2f86d2"

set -g status "on"
set -g status-justify "left"
set -g status-style "fg=#37567c,bg=#f3f3f3"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#ffffff,bg=#2f86d2,bold] #S #[fg=#011627,bg=#cccccc] #(whoami) #[fg=#37567c,bg=#f3f3f3] "
set -g status-right "#[fg=#5f7e97,bg=#f3f3f3] %Y-%m-%d #[fg=#011627,bg=#cccccc] %H:%M #[fg=#ffffff,bg=#2f86d2,bold] #h "

setw -g window-status-activity-style "underscore,fg=#b05f0a,bg=#f3f3f3"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#5f7e97,bg=#f3f3f3"
setw -g window-status-format "#[fg=#5f7e97,bg=#f3f3f3] #I  #W #F "
setw -g window-status-current-format "#[fg=#3e3e3e,bg=#e3e3e3,bold] #I  #W #F "

# tmux-plugins/tmux-prefix-highlight
set -g @prefix_highlight_output_prefix "#[fg=#b05f0a]#[bg=#f3f3f3]#[fg=#ffffff]#[bg=#b05f0a]"
set -g @prefix_highlight_output_suffix ""
