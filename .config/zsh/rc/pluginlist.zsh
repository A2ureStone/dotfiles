#==============================================================#
## Setup zinit                                                ##
#==============================================================#
# cSpell:disable
if [ -z "$ZPLG_HOME" ]; then
	ZPLG_HOME="$ZDATADIR/zinit"
fi

if ! test -d "$ZPLG_HOME"; then
	mkdir -p "$ZPLG_HOME"
	chmod g-rwX "$ZPLG_HOME"
	git clone --depth 10 https://github.com/zdharma-continuum/zinit.git ${ZPLG_HOME}/bin
fi

typeset -gAH ZPLGM
ZPLGM[HOME_DIR]="${ZPLG_HOME}"
source "$ZPLG_HOME/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


#==============================================================#
## Plugin load                                                ##
#==============================================================#

#--------------------------------#
# zinit extension
#--------------------------------#
zinit light-mode for \
	@zdharma-continuum/zinit-annex-readurl
#@zinit-zsh/z-a-bin-gem-node
#@zinit-zsh/z-a-patch-dl \
	#@zinit-zsh/z-a-unscope \
	#@zinit-zsh/z-a-default-ice \
	#@zinit-zsh/z-a-submods
#@zinit-zsh/z-a-man # -> require gem


#--------------------------------#
# completion
#--------------------------------#
zinit wait'0b' lucid \
	atload"source $ZHOMEDIR/rc/pluginconfig/zsh-autosuggestions_atload.zsh" \
	light-mode for @zsh-users/zsh-autosuggestions

zinit wait'0a' lucid \
	atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-autocomplete_atinit.zsh" \
	atload"source $ZHOMEDIR/rc/pluginconfig/zsh-autocomplete_atload.zsh" \
	light-mode for @marlonrichert/zsh-autocomplete

zinit wait'0b' lucid as"completion" \
	atload"source $ZHOMEDIR/rc/pluginconfig/zsh-completions_atload.zsh; zicompinit; zicdreplay" \
	light-mode for @zsh-users/zsh-completions


#--------------------------------#
# prompt
#--------------------------------#
# -> gitstatus(powerlevel10k)
# git_version=$(git --version | head -n1 | cut -d" " -f3)
# if [[ "$(version3 "$git_version")" -ge "$(version3 "2.11.0")" ]]; then
#   zinit ice lucid atload"source $ZHOMEDIR/rc/pluginconfig/git-prompt_atload.zsh"
#   zinit light woefe/git-prompt.zsh
# else
#   zinit ice lucid atload"source $ZHOMEDIR/rc/pluginconfig/zsh-git-prompt_atload.zsh"
#   zinit light olivierverdier/zsh-git-prompt
# fi

zinit wait'0a' lucid \
	if"(( ${ZSH_VERSION%%.*} > 4.4))" \
	atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
	atload"source $ZHOMEDIR/rc/pluginconfig/fast-syntax-highlighting.zsh" \
	light-mode for @zdharma-continuum/fast-syntax-highlighting

PROMPT="%~"$'\n'"> "
zinit wait'!0b' lucid depth=1 \
	atload"source $ZHOMEDIR/rc/pluginconfig/powerlevel10k_atload.zsh" \
	light-mode for @romkatv/powerlevel10k


#--------------------------------#
# history
#--------------------------------#
# Error occuers with zsh-autocomplete
# _histdb_query_batch:7: 27: bad file descriptor
# _histdb_query_batch:8: 27: bad file descriptor
#zinit wait'2' lucid \
	#  light-mode for @larkery/zsh-histdb

zinit wait'2' lucid \
	atinit"source $ZHOMEDIR/rc/pluginconfig/per-directory-history_atinit.zsh" \
	atload"_per-directory-history-set-global-history" \
	light-mode for @CyberShadow/per-directory-history
# https://github.com/jimhester/per-directory-history/issues/21
# https://github.com/jimhester/per-directory-history/issues/27
#  @jimhester/per-directory-history


#--------------------------------#
# alias
#--------------------------------#
zinit wait'0' lucid \
	light-mode for @unixorn/git-extra-commands

zinit wait'0a' lucid \
	atload"source $ZHOMEDIR/rc/pluginconfig/zsh-abbrev-alias_atinit.zsh" \
	light-mode for @momo-lab/zsh-abbrev-alias
# do not execute eval & do not map ~~
# zinit wait'!0a' lucid \
	#   atload"source $ZHOMEDIR/rc/pluginconfig/zsh-abbr_atinit.zsh" \
	#   light-mode for @olets/zsh-abbr


#--------------------------------#
# environment variable
#--------------------------------#
zinit wait'0' lucid \
	light-mode for @Tarrasch/zsh-autoenv


#--------------------------------#
# improve cd
#--------------------------------#
# zinit wait'1' lucid \
	#   atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-z_atinit.zsh" \
	#   light-mode for @agkozak/zsh-z
zinit wait'1' lucid \
	from"gh-r" as"program" pick"zoxide-*/zoxide" \
	atload"source $ZHOMEDIR/rc/pluginconfig/zoxide_atload.zsh" \
	light-mode for @ajeetdsouza/zoxide

zinit wait'1' lucid \
	light-mode for @mollifier/cd-gitroot

zinit wait'1' lucid \
	light-mode for @peterhurford/up.zsh

zinit wait'1' lucid \
	light-mode for @Tarrasch/zsh-bd

zinit wait'1' lucid \
	atinit"source $ZHOMEDIR/rc/pluginconfig/zshmarks_atinit.zsh" \
	light-mode for @jocelynmallon/zshmarks


#--------------------------------#
# git
#--------------------------------#
zinit wait'2' lucid \
	light-mode for @caarlos0/zsh-git-sync


#--------------------------------#
# fzf
#--------------------------------#
zinit wait'0b' lucid \
	from"gh-r" as"program" \
	atload"source $ZHOMEDIR/rc/pluginconfig/fzf_atload.zsh" \
	for @junegunn/fzf
zinit ice wait'0a' lucid
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
zinit ice wait'1a' lucid atload"source $ZHOMEDIR/rc/pluginconfig/fzf_completion.zsh_atload.zsh"
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/completion.zsh
zinit ice wait'0a' lucid as"program"
zinit snippet https://github.com/junegunn/fzf/blob/master/bin/fzf-tmux

zinit wait'1' lucid \
	pick"fzf-extras.zsh" \
	atload"source $ZHOMEDIR/rc/pluginconfig/fzf-extras_atload.zsh" \
	light-mode for @atweiden/fzf-extras # fzf

# after zsh-autocomplete & fzf_completion.zsh
#zinit wait'1c' lucid \
	#  atinit"source $ZHOMEDIR/rc/pluginconfig/fz_atinit.zsh" \
	#  light-mode for @changyuheng/fz

zinit wait'0c' lucid \
	pick"fzf-finder.plugin.zsh" \
	atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-plugin-fzf-finder_atinit.zsh" \
	light-mode for @leophys/zsh-plugin-fzf-finder

zinit wait'0c' lucid \
	atinit"source $ZHOMEDIR/rc/pluginconfig/fzf-mark_atinit.zsh" \
	light-mode for @urbainvaes/fzf-marks

zinit wait'1c' lucid \
	atinit"source $ZHOMEDIR/rc/pluginconfig/fzf-zsh-completions_atinit.zsh" \
	light-mode for @chitoku-k/fzf-zsh-completions

zinit wait'2' lucid \
	atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-fzf-widgets_atinit.zsh" \
	light-mode for @amaya382/zsh-fzf-widgets

# zinit wait'2' lucid \
	#   from"gh-r" as"program" \
	#   atload"source $ZHOMEDIR/rc/pluginconfig/pmy_atload.zsh" \
	#   for @relastle/pmy

zinit wait'2' lucid silent blockf depth"1" \
	atclone'deno cache --no-check ./src/cli.ts' \
	atpull'%atclone' \
	atinit"source $ZHOMEDIR/rc/pluginconfig/zeno_atinit.zsh" \
	atload"source $ZHOMEDIR/rc/pluginconfig/zeno_atload.zsh" \
	for @yuki-yano/zeno.zsh


#--------------------------------#
# extension
#--------------------------------#
zinit wait'1' lucid \
	atload"source $ZHOMEDIR/rc/pluginconfig/emoji-cli_atload.zsh" \
	light-mode for @b4b4r07/emoji-cli

# zinit wait'0' lucid \
	#   light-mode for @t413/zsh-background-notify
if [[ -z "$SSH_CONNECTION" ]]; then
	zinit wait'0' lucid \
		atload"source $ZHOMEDIR/rc/pluginconfig/zsh-auto-notify_atload.zsh" \
		light-mode for @MichaelAquilina/zsh-auto-notify
fi

zinit wait'0' lucid \
	light-mode for @mafredri/zsh-async

zinit wait'0' lucid \
	atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-completion-generator_atinit.zsh" \
	light-mode for @RobSis/zsh-completion-generator

zinit wait'2' lucid \
	light-mode for @hlissner/zsh-autopair

# cannot be disabled bindkey '^T' zsh-startify
#zplugin wait'2' lucid \
	#  light-mode for @zdharma/zsh-startify
# don't like this color
# zinit pack for ls_colors
# zinit pack for dircolors-material

#--------------------------------#
# enhancive command
#--------------------------------#
zinit wait'1' lucid \
	from"gh-r" as"program" pick"eza" \
	atload"source $ZHOMEDIR/rc/pluginconfig/eza_atload.zsh" \
	light-mode for @eza-community/eza

zinit wait'1' lucid blockf nocompletions \
	from"gh-r" as'program' pick'ripgrep*/rg' \
	cp"ripgrep-*/complete/_rg -> _rg" \
	atclone'chown -R $(id -nu):$(id -ng) .; zinit creinstall -q BurntSushi/ripgrep' \
	atpull'%atclone' \
	light-mode for @BurntSushi/ripgrep

zinit wait'1' lucid blockf nocompletions \
	from"gh-r" as'program' cp"fd-*/autocomplete/_fd -> _fd" pick'fd*/fd' \
	atclone'chown -R $(id -nu):$(id -ng) .; zinit creinstall -q sharkdp/fd' \
	atpull'%atclone' \
	light-mode for @sharkdp/fd

zinit wait'1' lucid \
	from"gh-r" as"program" cp"bat/autocomplete/bat.zsh -> _bat" pick"bat*/bat" \
	atload"export BAT_THEME='Nord'; alias cat=bat" \
	light-mode for @sharkdp/bat

zinit wait'1' lucid \
	from"gh-r" as"program" \
	atload"alias rm='trash put'" \
	light-mode for @oberblastmeister/trashy

zinit wait'1' lucid \
	from"gh-r" as"program" mv'tealdeer* -> tldr' \
	light-mode for @dbrgn/tealdeer
zinit ice wait'1' lucid as"completion" mv'zsh_tealdeer -> _tldr'
zinit snippet https://github.com/dbrgn/tealdeer/blob/main/completion/zsh_tealdeer

zinit wait'1' lucid \
	from"gh-r" as"program" bpick'*linux*' \
	light-mode for @dalance/procs

zinit wait'1' lucid \
	from"gh-r" as"program" pick"delta*/delta" \
	atload"compdef _gnu_generic delta" \
	light-mode for @dandavison/delta

zinit wait'1' lucid \
	from"gh-r" as"program" pick"mmv*/mmv" \
	light-mode for @itchyny/mmv


#--------------------------------#
# program
#--------------------------------#
# zsh
if [[ "${ZSH_INSTALL}" == "true" ]]; then
	# zinit pack for zsh
	if builtin command -v make > /dev/null 2>&1; then
		zinit id-as=zsh as"null" lucid depth=1 \
			atclone"./.preconfig; m {hi}Building Zsh...{rst}; \
			CPPFLAGS='-I/usr/include -I/usr/local/include' CFLAGS='-g -O2 -Wall' LDFLAGS='-L/usr/libs -L/usr/local/libs' \
			./configure --prefix=\"$ZPFX\" \
			--enable-multibyte \
			--enable-function-subdirs \
			--with-tcsetpgrp \
			--enable-pcre \
			--enable-cap \
			--enable-zsh-secure-free \
			>/dev/null && \
			{ type yodl &>/dev/null || \
				{ m -u2 {warn}WARNING{ehi}:{rst}{warn} No {cmd}yodl{warn}, manual pages will not be built.{rst}; ((0)); } && \
			{ make install; ((1)); } || make install.bin install.fns install.modules } >/dev/null && \
			{ type sudo &>/dev/null && sudo cp -vf Src/zsh /usr/local/bin/zsh; ((1)); } && \
			m {success}The build succeeded.{rst} || m {failure}The build failed.{rst}" \
			atpull"%atclone" nocompile countdown git \
			for @zsh-users/zsh
	fi
fi

# git
if builtin command -v make > /dev/null 2>&1; then
	zinit wait'0' lucid nocompile \
		id-as=git as='null|readurl' \
		mv"%ID% -> git.tar.gz" \
		atclone'ziextract --move --auto git.tar.gz && \
		make -j $[$(grep cpu.cores /proc/cpuinfo | sort -u | sed "s/[^0-9]//g") + 1] prefix=$ZPFX all install && \
		\rm -rf $ZINIT[SNIPPETS_DIR]/git/*' \
		atpull"%atclone" \
		dlink='/git/git/archive/refs/tags/v%VERSION%.tar.gz' \
		for https://github.com/git/git/tags/
fi

# neovim
zinit wait'0' lucid nocompletions \
	from'gh-r' ver'nightly' as'program' bpick'*tar.gz' \
	atclone"command cp -rf nvim*/* $ZPFX; echo "" > ._zinit/is_release" \
	atpull'%atclone' \
	run-atpull \
	atload"source $ZHOMEDIR/rc/pluginconfig/neovim_atload.zsh" \
	light-mode for @neovim/neovim

# wezterm
# test $(openssl version | awk '{print $2}' | awk -F '.' '{print $1}') -eq 1
# -> bpick"*20.04.tar.xz"
zinit wait'2' lucid nocompletions \
	from"gh-r" ver"nightly"  as"program" bpick"*22.04.tar.xz" \
	atclone"command cp -rf wezterm/usr/* $ZPFX; ln -snf $ZPFX/bin/wezterm ~/.local/bin/x-terminal-emulator; echo "" > ._zinit/is_release" \
	atpull'%atclone' \
	run-atpull \
	light-mode for @wez/wezterm

# node (for coc.nvim)
# zinit wait'0' lucid id-as=node as='readurl|command' \
	#   nocompletions nocompile extract \
	#   pick'node*/bin/*' \
	#   dlink='node-v%VERSION%-linux-x64.tar.gz' \
	#   for https://nodejs.org/download/release/latest/

## tmux
#if ldconfig -p | grep -q 'libevent-' && ldconfig -p | grep -q 'libncurses'; then
#  zinit wait'0' lucid \
	#    from"gh-r" as"program" bpick"tmux-*.tar.gz" pick"*/tmux" \
	#    atclone"cd tmux*/; ./configure; make" \
	#    atpull"%atclone" \
	#    light-mode for @tmux/tmux
#elif builtin command -v tmux > /dev/null 2>&1 && test $(echo "$(tmux -V | cut -d' ' -f2) <= "2.5"" | tr -d '[:alpha:]' | bc) -eq 1; then
#  zinit wait'0' lucid \
	#    from'gh-r' as'program' bpick'*AppImage*' mv'tmux* -> tmux' pick'tmux' \
	#    light-mode for @tmux/tmux
#fi

# zinit wait'1' lucid \
	#   as"program" \
	#   pick'bin/*' \
	#   light-mode for @greymd/tmux-xpanes

# translation #
zinit wait'1' lucid \
	ver"stable" pullopts"--rebase" \
	light-mode for @soimort/translate-shell

# Not much use.
# if builtin command -v pip > /dev/null 2>&1; then
# 	zinit wait'1' lucid \
	# 		as"null" \
	# 		atclone"pip install -U deep-translator" \
	# 		atpull'%atclone' \
	# 		light-mode for @nidhaloff/deep-translator
# fi

# zinit wait'1' lucid \
	#   from"gh-r" as"program" \
	#   atload"source $ZHOMEDIR/rc/pluginconfig/nextword_atload.zsh" \
	#   light-mode for @high-moctane/nextword
zinit wait'1' lucid \
	from"gh-r" as"program" \
	mv'mocword* -> mocword' \
	atload"source $ZHOMEDIR/rc/pluginconfig/mocword_atload.zsh" \
	light-mode for @high-moctane/mocword

# zinit wait'1' lucid \
	# 	atinit"source $ZHOMEDIR/rc/pluginconfig/asdf_atinit.zsh" \
	# 	atload"source $ZHOMEDIR/rc/pluginconfig/asdf_atload.zsh" \
	# 	pick"asdf.sh" \
	# 	light-mode for @asdf-vm/asdf
zinit wait'1' lucid \
	from"gh-r" as"program" \
	mv'rtx-* -> rtx' \
	atload"source $ZHOMEDIR/rc/pluginconfig/rtx_atload.zsh" \
	light-mode for @jdx/rtx

# GitHub #
zinit wait'1' lucid \
	from"gh-r" as"program" pick"ghq*/ghq" \
	atload"source $ZHOMEDIR/rc/pluginconfig/ghq_atload.zsh" \
	light-mode for @x-motemen/ghq

zinit wait'1' lucid \
	from"gh-r" as"program" pick"ghg*/ghg" \
	light-mode for @Songmu/ghg

zinit wait'1' lucid \
	from"gh-r" as'program' bpick'*linux_*.tar.gz' pick'gh*/**/gh' \
	atload"source $ZHOMEDIR/rc/pluginconfig/gh_atload.zsh" \
	light-mode for @cli/cli

# zinit wait'1' lucid \
	# 	from"gh-r" as"program" cp"hub-*/etc/hub.zsh_completion -> _hub" pick"hub-*/bin/hub" \
	# 	atload"source $ZHOMEDIR/rc/pluginconfig/hub_atload.zsh" \
	# 	for @mislav/hub

# snippet
[[ $- == *i* ]] && stty -ixon
zinit wait'1' lucid blockf nocompletions \
	from"gh-r" as"program" pick"pet" bpick'*linux_amd64.tar.gz' \
	atclone'chown -R $(id -nu):$(id -ng) .; zinit creinstall -q knqyf263/pet' \
	atpull'%atclone' \
	atload"source $ZHOMEDIR/rc/pluginconfig/pet_atload.zsh" \
	for @knqyf263/pet

# etc #
zinit wait'1' lucid \
	as"program" pick"emojify" \
	light-mode for @mrowa44/emojify


#==============================================================#
# my plugins
#==============================================================#
zinit wait'1' lucid \
	atload"source $ZHOMEDIR/rc/pluginconfig/mru.zsh_atload.zsh" \
	light-mode for "$ZHOMEDIR/rc/myplugins/mru.zsh/"
zinit wait'1' lucid \
	pick"*.sh" \
	light-mode for "$ZHOMEDIR/rc/myplugins/vte/"
# zinit wait'2' lucid \
	#   light-mode for "$ZHOMEDIR/rc/myplugins/coc-project.zsh/"


#==============================================================#
# Analytics
#==============================================================#
if [[ "${DISABLE_WAKATIME}" != "true" ]]; then
	zinit wait'2' lucid \
		atpull'python -c "$(wget -q -O - https://raw.githubusercontent.com/wakatime/vim-wakatime/master/scripts/install_cli.py)"' \
		light-mode for @sobolevn/wakatime-zsh-plugin
fi


#==============================================================#
# completion
#==============================================================#
zinit wait'2' lucid silent \
	atload"zicompinit; zicdreplay" \
	light-mode for "$ZHOMEDIR/rc/myplugins/command_config.zsh"

#==============================================================#
# vim plugin
#==============================================================#
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

#==============================================================#
# local plugins
#==============================================================#
[ -f "$HOME/.zshrc.plugin.local" ] && source "$HOME/.zshrc.plugin.local"