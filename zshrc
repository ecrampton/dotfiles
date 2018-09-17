# -*- sh -*-

# TODO: I need bash style backword word delete

# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

typeset -U path

if [ -d "$HOME/software/boost" ]; then
    export BOOST_ROOT=$HOME/software/boost
    export LD_LIBRARY_PATH=$HOME/software/boost/lib:$LD_LIBRARY_PATH
fi

if [ -d "$HOME/software/zsh" ]; then
    path+=($HOME/software/zsh/bin)
fi

if [ -d "$HOME/software/emacs" ]; then
    path+=($HOME/software/emacs/bin)
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

if [ -d "$HOME/software/bullseye" ]; then
    path[1,0]=($HOME/software/bullseye/bin)
    export COVFILE=/tmp/coverage.cov
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

if [ -d "/opt/icecream/bin" ]; then
    path[1,0]=/opt/icecream/bin
    if [ -f "$HOME/a0dfe72293a098191d6964924aa7b4c5.tar.gz" ]; then
	export ICECC_VERSION=$HOME/a0dfe72293a098191d6964924aa7b4c5.tar.gz
    fi
    if [ -f "$HOME/0a4466389b64717a2788d62ae7538490.tar.gz" ]; then
	export ICECC_VERSION=$HOME/0a4466389b64717a2788d62ae7538490.tar.gz
    fi
    if [ -f "$HOME/c980925405d549748a2ad4f9ad7d2ca6.tar.gz" ]; then
        export ICECC_VERSION=$HOME/c980925405d549748a2ad4f9ad7d2ca6.tar.gz
    fi
    export COVFILE=$HOME/cpp/bats.cov
fi

if [ -d "$HOME/software/bullseye/bin" ]; then
    path[1,0]=$HOME/software/bullseye/bin
fi

if [ -d "$HOME/go" ]; then
    export GOPATH=$HOME/go
    path+=($HOME/go/bin)
fi

if [ -d "$HOME/software/protobuf-3.0.0" ]; then
    path+=($HOME/software/protobuf-3.0.0/bin)
fi

export EDITOR="emacs -nw"
export SITKA_ROOT=$HOME/sitka
export SITKA_ENVIRONMENT=dev

if [ -d $HOME/software/simple-binary-encoding ]; then
    export SBE_HOME=$HOME/software/simple-binary-encoding
fi

# Force use of color.
case "$TERM" in
xterm)
    export TERM=xterm-256color
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

#function parse_git_branch {
#    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#    echo "("${ref#refs/heads/}")"
#}

if [ `uname` = "Linux" ]; then
    alias ls='ls --color=auto'
fi

if [ `uname` = "FreeBSD" ]; then
    alias ls='ls -G'
fi

alias bsql='bsql.sh'
#alias ninja='ninja-build'

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

source $HOME/dotfiles/submodules/zsh-git-prompt/zshrc.sh
ZSH_THEME_GIT_PROMPT_PREFIX="${axiomatic_purple}("
ZSH_THEME_GIT_PROMPT_SUFFIX="${axiomatic_purple})"
ZSH_THEME_GIT_PROMPT_SEPARATOR="${axiomatic_purple2}|"
ZSH_THEME_GIT_PROMPT_BRANCH="${jungle_green}"
PROMPT='${mystic_blue}[%n${victory_blue2}@%m${axiomatic_purple} ${jungle_green}%~${mystic_blue}]${deep_gold}%#${PR_RST} '

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
