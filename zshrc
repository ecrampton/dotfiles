# -*- sh -*-

# TODO: I need bash style backword word delete

# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

if [ -d "$HOME/software/zsh" ]; then
    export PATH=$HOME/software/zsh/bin:$PATH
fi

if [ -d "$HOME/software/emacs" ]; then
    export PATH=$HOME/software/emacs/bin:$PATH
fi

if [ -d "$HOME/software/tmux" ]; then
    export PATH=$HOME/software/tmux/bin:$PATH
fi

if [ -d "$HOME/software/vim" ]; then
    export PATH=$HOME/software/vim/bin:$PATH
fi

if [ -d "$HOME/software/jdk" ]; then
    export PATH=$HOME/software/jdk/bin:$PATH
    export JAVA_HOME=$HOME/software/jdk
fi

if [ -d "$HOME/software/activator" ]; then
    export PATH=$HOME/software/activator:$PATH
fi

if [ -d "$HOME/software/sbt" ]; then
    export PATH=$HOME/software/sbt/bin:$PATH
fi

if [ -d "/opt/icecream/bin" ]; then
    export PATH=/opt/icecream/bin:$PATH
    export ICECC_VERSION=$HOME/a0dfe72293a098191d6964924aa7b4c5.tar.gz
    export COVFILE=$HOME/cpp/bats.cov
fi

if [ -d "$HOME/software/bullseye/bin" ]; then
    export PATH=$HOME/software/bullseye/bin:$PATH
fi

export EDITOR="emacs -nw"

# Force use of color.
case "$TERM" in
xterm)
    # Contrary to all documentation, this is wrong and should be
    # xterm-256color. But it's the only way to get arrow keys working
    # in all environments I use in all terminals I use.
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

#function parse_git_branch {
#    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#    echo "("${ref#refs/heads/}")"
#}

alias ls='ls --color=auto'
alias ninja='ninja-build'

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

#autoload -Uz vcs_info
#zstyle ':vcs_info:*' stagedstr 's'
#zstyle ':vcs_info:*' unstagedstr 'u'
#zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
#zstyle ':vcs_info:*' formats \
#       " ${mystic_blue}[${undergrowth_green}%b${mystic_blue}]${axiomatic_purple}%c${victory_blue2}%u%m%f"
##zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-aheadbehind
#zstyle ':vcs_info:*' enable git
#
#function +vi-git-untracked() {
#    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
#           [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
#        hook_com[unstaged]+='%F{1}??%f'
#    fi
#}
#
#### git: Show +N/-N when your local branch is ahead-of or behind remote HEAD.
## Make sure you have added misc to your 'formats':  %m
#function +vi-git-aheadbehind() {
#    local ahead behind
#    local -a gitstatus
#
#    # for git prior to 1.7
#    # ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
#    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l | tr -d ' ')
#    (( $ahead )) && gitstatus+=( "${mystic_blue}(${cold_mud}+${ahead}${mystic_blue})%f" )
#
#    # for git prior to 1.7
#    # behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
#    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l | tr -d ' ')
#    (( $behind )) && gitstatus+=( "%{mystic_blue}(%{cold_mud}-${behind}%{mystic_blue})%f" )
#
#    hook_com[misc]+=${(j::)gitstatus}
#}
#
#precmd () { vcs_info }
#
#setopt PROMPT_SUBST
#PS1='${mystic_blue}[%n${victory_blue2}@%m${axiomatic_purple}${vcs_info_msg_0_} ${jungle_green}%~${mystic_blue}]${deep_gold}%#${PR_RST} '

source $HOME/dotfiles/submodules/zsh-git-prompt/zshrc.sh
ZSH_THEME_GIT_PROMPT_PREFIX="${axiomatic_purple}("
ZSH_THEME_GIT_PROMPT_SUFFIX="${axiomatic_purple})"
ZSH_THEME_GIT_PROMPT_SEPARATOR="${axiomatic_purple2}|"
ZSH_THEME_GIT_PROMPT_BRANCH="${jungle_green}"
PROMPT='${mystic_blue}[%n${victory_blue2}@%m${axiomatic_purple}:$(git_super_status) ${jungle_green}%~${mystic_blue}]${deep_gold}%#${PR_RST} '

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
