# # export FZF_COMPLETION_TRIGGER=';'
# export FZF_COMPLETION_TRIGGER=''
# # bindkey '^^' fzf-completion
# # bindkey '^I' menu-select

# if builtin command -v auto-fu > /dev/null 2>&1; then
# 	bindkey '^I' afu+complete-word
# elif zle -l | \grep -q 'menu-select' > /dev/null 2>&1; then
# 	bindkey '^I' menu-select
# else
# 	bindkey '^I' menu-complete
# fi
# if builtin command -v .autocomplete.__init__ > /dev/null 2>&1; then
#   bindkey '^I' menu-select
# fi

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# # Options to fzf command
# export FZF_COMPLETION_OPTS='--border --info=inline'

# # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# # - The first argument to the function ($1) is the base path to start traversal
# # - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# # Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# # Advanced customization of fzf options via _fzf_comprun function
# # - The first argument to the function is the name of the command.
# # - You should make sure to pass the rest of the arguments to fzf.
# _fzf_comprun() {
#   local command=$1
#   shift

#   case "$command" in
#     cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
#     export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
#     ssh)          fzf --preview 'dig {}'                   "$@" ;;
#     *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
#   esac
# }