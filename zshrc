# -*- sh -*-

# TODO: I need bash style backword word delete

# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

typeset -U path

if [ -d "$HOME/software/zsh" ]; then
    path+=($HOME/software/zsh/bin)
fi

if [ -d "$HOME/software/emacs" ]; then
    path[1,0]=$HOME/software/emacs/bin
fi

if [ -d "$HOME/software/tmux" ]; then
    path+=($HOME/software/tmux/bin)
fi

if [ -d "$HOME/software/vim" ]; then
    path+=($HOME/software/vim/bin)
fi

if [ -d "$HOME/software/jdk" ]; then
    path+=($HOME/software/jdk/bin)
    export JAVA_HOME=$HOME/software/jdk
fi

if [ -d "/opt/bats/bin" ]; then
    path[1,0]=/opt/bats/bin
fi

if [ -d "/opt/ecn/scripts" ]; then
    path+=(/opt/ecn/scripts)
fi

if [ -d "/opt/ecn/bin" ]; then
    path+=(/opt/ecn/bin)
fi

#if [ -f "$HOME/icecream/clang" ]; then
#    path[1,0]=/usr/libexec/icecc/bin
#    export ICECC_VERSION=$HOME/icecream/8ec23b6b05ddfecafd93f005b8f17b85.tar.gz
#    export ICECC_CC=/opt/bats/bin/clang
#    export ICECC_CXX=/opt/bats/bin/clang++
#    export CC=clang
#    export CXX=clang++
#
#fi

if [ -d "$HOME/software/bullseye" ]; then
    path[1,0]=$HOME/software/bullseye/bin
    export COVFILE=$HOME/cpp/bats.cov
    export COVAUTOSAVE=0
fi

if [ -d "$HOME/.cargo/bin" ]; then
    path[1,0]=$HOME/.cargo/bin
fi

if [ -x `which fd` ]; then
    export FZF_DEFAULT_COMMAND='fd --type f'
fi

export 'NINJA_STATUS=[%u/%r/%f] '
export EDITOR=nvim

# Force use of color.
case "$TERM" in
xterm)
    export TERM=screen-256color
    ;;
xterm-256color)
    export TERM=screen-256color
    ;;
screen)
    export TERM=screen-256color
    ;;
esac

autoload -U select-word-style
select-word-style bash

alias bsql='bsql.sh'
alias bbut='./bb --use-ib -j1500 --targets=ecn_unit_test_suite'
alias qbbut='./bb --use-ib -j1500 --targets=ecn_unit_test_suite'

if [ `uname` = "Linux" ]; then
    alias ls='ls --color=auto'
fi

if [ `uname` = "FreeBSD" ]; then
    alias ls='ls -G'
fi

deep_gold="%F{214}"
jungle_green="%F{151}"
cold_mud="%F{181}"
victory_blue1="%F{109}"
victory_blue2="%F{111}"
mystic_blue="%F{60}"
axiomatic_purple="%F{133}"
axiomatic_purple2="%F{91}"
jungle_green="%F{149}"
brick_red="%F{173}"
relaxed_white="%F{188}"
undergrowth_green="%F{107}"
PR_RST="%{${reset_color}%}"

autoload -Uz compinit
autoload -U colors && colors

#source $HOME/dotfiles/submodules/zsh-git-prompt/zshrc.sh
#ZSH_THEME_GIT_PROMPT_PREFIX="${axiomatic_purple}("
#ZSH_THEME_GIT_PROMPT_SUFFIX="${axiomatic_purple})"
#ZSH_THEME_GIT_PROMPT_SEPARATOR="${axiomatic_purple2}|"
#ZSH_THEME_GIT_PROMPT_BRANCH="${jungle_green}"
#PROMPT='${mystic_blue}[%n${victory_blue2}@%m${axiomatic_purple}:$(git_super_status) ${jungle_green}%~${mystic_blue}]${deep_gold}%#${PR_RST} '
PROMPT="${mystic_blue}[%n${victory_blue2}@%m${axiomatic_purple}: ${jungle_green}%~${mystic_blue}]${deep_gold}%#${PR_RST} "

source $HOME/dotfiles/submodules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=196'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=208'
ZSH_HIGHLIGHT_STYLES[command]='fg=149'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=173'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=178'
ZSH_HIGHLIGHT_STYLES[path]='fg=214'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=173'

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob notify
bindkey -e
bindkey ';5D' emacs-backward-word
bindkey ';5C' emacs-forward-word
bindkey ';5A' up-line-or-search
bindkey ';5B' down-line-or-search

zstyle :compinstall filename "$HOME/.zshrc"
zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
