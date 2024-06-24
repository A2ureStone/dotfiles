#==============================================================#
##          Key Bindings                                      ##
#==============================================================#

# alt keys '^[' are tmux's bindkey

stty intr '^C'        # Ctrl+C cancel
stty susp '^Z'        # Ctrl+Z suspend
stty stop undef

# zsh key bindings (also determine if EDITOR=vi)
bindkey -v     # vi like

# remap
bindkey -s '^[[32;2u' ' '

## history ##
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# broken with auto-suggestion
#bindkey '^P' history-beginning-search-backward-end
#bindkey '^N' history-beginning-search-forward-end
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward
#bindkey '^[[A' history-beginning-search-backward-end
#bindkey '^[[B' history-beginning-search-forward-end
# history incremental search 与fzf冲突，加isearch前进和后退
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
autoload -Uz smart-insert-last-word
# Words of length 2 or more containing at least one of [a-zA-Z], /, or \
	zstyle :insert-last-word match '*([[:alpha:]/\\]?|?[[:alpha:]/\\])*'
zle -N insert-last-word smart-insert-last-word
function _insert-last-word() { smart-insert-last-word; ARG=-2 }
zle -N _insert-last-word
bindkey '^]' _insert-last-word
function insert-next-word() { zle insert-last-word -- 1 -1; ARG=-2 }
zle -N insert-next-word
bindkey '^_' insert-next-word
function zle-line-finish() { ARG=-2 }
zle -N zle-line-finish
function insert-prev-arg() { zle insert-last-word -- 0 ${ARG:-2}; ARG=$(($ARG-1)) }
zle -N insert-prev-arg
bindkey '^^' insert-prev-arg
bindkey '\e#' pound-insert

## cd ##
function cd-up { zle push-line && LBUFFER='builtin cd ..' && zle accept-line }
zle -N cd-up
zle -N dir_forward
zle -N dir_back
bindkey '^[[1;6C' dir_forward
bindkey '^[[1;6D' dir_back

## completion ##
# shift-tab to reverse completion
zmodload zsh/complist
bindkey '^[[Z' reverse-menu-complete
bindkey -M menuselect '^[[Z' reverse-menu-complete

# edit command-line using editor (like fc command)
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

## etc ##
# Check wildcard expansion
bindkey '^X*' expand-word
# stack command(目前没用到stack功能)
zle -N show_buffer_stack
bindkey '^Q' show_buffer_stack

# Remap reserved keys
# C-g
# C-j fzf-preview
# C-o mru
# C-t find file
# C-y completion
# C-s snippet
