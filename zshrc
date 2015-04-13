# -*- sh -*-

# TODO: I need bash style backword word delete

# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

if [ -d "$HOME/software/emacs" ]; then
    export PATH=$HOME/software/emacs/bin:$PATH
fi

autoload -Uz compinit
autoload -U colors && colors

alias ls='ls --color=auto'

deep_gold="%F{214}"
jungle_green="%F{151}"
cold_mud="%F{181}"
victory_blue1="%F{109}"
victory_blue2="%F{111}"
mystic_blue="%F{60}"
axiomatic_purple="%F{133}"
PR_RST="%{${reset_color}%}"

PS1="${mystic_blue}[%n${victory_blue2}@%m${axiomatic_purple} %~${mystic_blue}]${deep_gold}%#${PR_RST} "

source $HOME/dotfiles/submodules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=196'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=208'
ZSH_HIGHLIGHT_STYLES[command]='fg=109'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=178'
ZSH_HIGHLIGHT_STYLES[path]='fg=214'

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob notify
bindkey -e

zstyle :compinstall filename '/home/ecrampton/.zshrc'
zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

compinit
