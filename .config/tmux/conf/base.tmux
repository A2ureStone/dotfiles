#--------------------------------------------------------------#
##          Base                                              ##
#--------------------------------------------------------------#

# Change prefix key
set-option -g prefix C-Space
unbind C-b
bind C-Space send-prefix

# Upgrade $TERM
set-option -g default-terminal "screen-256color"

# Default shell
set-option -g default-shell $SHELL
set-option -g default-command $SHELL

# Start window index at 1
set-option -g base-index 1

# Start pane index at 1
set-window-option -g pane-base-index 1

# Pad the gap in window
set-option -g renumber-windows on

# Maximum number of lines in window history
set-option -g history-limit 50000

# Message display seconds
set-option -g display-time 4000

# Do not use alternate screen buffer (when parent terminal's TERM is xterm)
set-option -ga terminal-overrides ",xterm*:Tc"
set-option -ga terminal-overrides ",xterm*:smcup@:rmcup@"
set-option -ga terminal-overrides ',rxvt-uni*:XT:Ms=\E]52;%p1%s;%p2%s\007'
set-option -ga terminal-overrides ',*:U8=0'
set-option -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'

# Use vi key bindings
set-option -g mode-keys vi

# copy text from tmux
set-option -g set-clipboard on

# Enable visual notifications
# TODO
set-window-option -g monitor-activity on
set-option -g visual-activity off

# bell
# TODO
set-option -g bell-action other
set-option -g visual-bell off

# Esc seems to work well.
# TODO
set-option -s escape-time 20

# Switch to simultaneous pane input
set-option -g synchronize-panes off

# Switch to mouse operation
set-option -g mouse off

# Use arrow keys to move panes
# TODO
set-window-option -g xterm-keys on

set-option -g status on
set-option -g status-position top
set-option -g status-interval 2

# emacs key bindings in tmux command prompt (prefix + :) are better than
# vi keys, even for vim users
# TODO
set-option -g status-keys emacs

# focus events enabled for terminals that support them
# TODO
set-option -g focus-events on

# super useful when using "grouped sessions" and multi-monitor setup
set-window-option -g aggressive-resize on

# change window title
# TODO
set-option -g set-titles on
set-option -g set-titles-string '#T'
set-window-option -g automatic-rename on

# change word delimiter
set-option -g word-separators " -_()@,[]{}:=/"

# pane-border("single", "double", "heavy", "simple", "number", NULL)
# TODO
set-option -g pane-border-lines heavy

#--------------------------------------------------------------#
##          Environments                                       ##
#--------------------------------------------------------------#
set-environment -g TMUX_DATA_DIR "${HOME}/.local/share/tmux"

