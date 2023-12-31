#--------------------------------------------------------------#
##          Plugins                                           ##
#--------------------------------------------------------------#
# cSpell:disable

set-option -g @plugin "tmux-plugins/tpm"
set-option -g @plugin "tmux-plugins/tmux-resurrect"
set-option -g @plugin "tmux-plugins/tmux-continuum"
set-option -g @plugin "tmux-plugins/tmux-copycat"
set-option -g @plugin "tmux-plugins/tmux-yank"
set-option -g @plugin "tmux-plugins/vim-tmux-focus-events"
if 'builtin command -v xdg-open > /dev/null 2>&1 ' \
  'set-option -g @plugin "tmux-plugins/tmux-open"'
set-option -g @plugin "jschaf/tmux-newline-detector"

set-option -g @nord_tmux_show_status_content "0"
set-option -g @plugin 'nordtheme/tmux'
#+--- Status Bars ---+
set -g status-left "#[fg=black,bg=blue,bold] #S #[fg=blue,bg=black,nobold,noitalics,nounderscore]"
set -g status-right "#{prefix_highlight}Online:#{online_status}#{cpu_bg_color}CPU:#{cpu_icon}#{cpu_percentage}#{ram_bg_color} RAM:#{ram_icon}#{ram_percentage} #[fg=brightblack,bg=black,nobold,noitalics,nounderscore]#[fg=white,bg=brightblack] %Y-%m-%d #[fg=white,bg=brightblack,nobold,noitalics,nounderscore]#[fg=white,bg=brightblack] %H:%M #[fg=cyan,bg=brightblack,nobold,noitalics,nounderscore]#[fg=black,bg=cyan,bold] #H "
set-option -g status-right-length 450

# TODO check for interact with nord tmux
set-option -g @plugin 'tmux-plugins/tmux-prefix-highlight'
# TODO add online check
set-option -g @plugin 'tmux-plugins/tmux-online-status'
set-option -g @plugin 'tmux-plugins/tmux-cpu'

if 'builtin command -v urlview > /dev/null 2>&1 ' \
  'set-option -g @plugin "tmux-plugins/tmux-urlview"'
set-option -g @plugin 'Morantron/tmux-fingers'
if 'builtin command -v fpp > /dev/null 2>&1 ' \
  'set -g @plugin "jbnicolai/tmux-fpp"'
set-option -g @plugin 'roy2220/easyjump.tmux'

set-option -g @plugin 'sainnhe/tmux-fzf'
set-option -g @plugin 'laktak/extrakto'
#set-option -g @plugin 'stephencookdev/tmux-workspace-groupings'


#--------------------------------------------------------------#
##          Install/Execute tpm                               ##
#--------------------------------------------------------------#

TMUX_PLUGIN_MANAGER_PATH="${TMUX_DATA_DIR}/plugins"
if '[ ! -d ${TMUX_PLUGIN_MANAGER_PATH}/tpm ]' \
  'run-shell "git clone --depth 1 https://github.com/tmux-plugins/tpm ${TMUX_PLUGIN_MANAGER_PATH}/tpm"'

if '[ -f ${TMUX_PLUGIN_MANAGER_PATH}/tpm/tpm ]' \
  'run-shell "${TMUX_PLUGIN_MANAGER_PATH}/tpm/tpm"'

#--------------------------------------------------------------#
##          Plugins Config                                    ##
#--------------------------------------------------------------#

set -g @continuum-restore 'on'

set -g @resurrect-dir "${TMUX_PLUGIN_MANAGER_PATH}/../resurrect"

if '[ -f ${TMUX_PLUGIN_MANAGER_PATH}/tmux-newline-detector/scripts/paste.sh ]' \
  'bind -n C-M-down run-shell "${TMUX_PLUGIN_MANAGER_PATH}/tmux-newline-detector/scripts/paste.sh"'

set -g @fingers-key S
set -g @fingers-highlight-format '#[fg=green,bold,dim]%s'
set -g @fingers-hint-format '#[fg=yellow,bold,dim]%s'
# tmux set-environment -g EXEC_PREFIX "DISPLAY=$DISPLAY"
set-environment -g EXEC_PREFIX "DISPLAY=$DISPLAY"
bind-key -n M-g  run-shell "${TMUX_PLUGIN_MANAGER_PATH}/tmux-fingers/scripts/tmux-fingers.sh"

set -g @fpp-key 'v'

set -g @cpu_percentage_format '%2.0f%%'
set -g @cpu_low_fg_color "#[fg=colour231]"
set -g @cpu_medium_fg_color "#[fg=colour231]"
set -g @cpu_high_fg_color "#[fg=colour33]"
set -g @ram_percentage_format '%2.0f%%'
set -g @ram_low_fg_color "#[fg=colour231]"
set -g @ram_medium_fg_color "#[fg=colour231]"
set -g @ram_high_fg_color "#[fg=colour33]"
set -g @cpu_medium_thresh "70"
set -g @cpu_high_thresh "90"

set -g @tmux-fzf-launch-key 'C-f'

set-option -g @easyjump-key-binding "j"
set-option -g @easyjump-label-chars "fjdkslaghrueiwoqptyvncmxzb1234567890"
set-option -g @easyjump-label-attrs "\e[1m\e[38;5;172m"
set-option -g @easyjump-text-attrs "\e[0m\e[38;5;237m"
set-option -g @easyjump-smart-case "on"