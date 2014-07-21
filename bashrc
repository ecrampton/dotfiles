# -*- sh -*-
# .bashrc

# ----------------------------------------------------------------------
# Basic bash preferences.

# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

# Prompt. Emacs uses the "dumb" terminal type; don't try to use color sequences there.
if [ "$TERM" != "dumb" ]; then
    export PS1='\[\e[1;33m\][\u@\h \W]\$\[\e[0m\] '
fi

# Don't put duplicate lines in the history.
export HISTCONTROL=ignoredups

# Check the window size after each command and update the values of
# LINES and COLUMNS if necessary.
shopt -s checkwinsize

# Append to .bash_history rather than overwriting.
shopt -s histappend

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# --------------------------------------------------------------------------------
# Bash history settings.

# Force unsaved history after each prompt.
export PROMPT_COMMAND='history -a'

# Log timestamps for each history entry.
export HISTTIMEFORMAT="%F %T | "

# ----------------------------------------------------------------------
# Basic UNIX setup.

# If available, make less more friendly for non-text input
# files. Ubuntu calls this 'lesspipe'. On Fedora, it's 'lesspipe.sh',
# but already enabled by default.

[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# --------------------------------------------------------------------------------
# Colors and prompts.

# Enable color support of ls where available.
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

# If this shell is running in an xterm, set the title to
# user@host:dir.

case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='history -a; echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    PROMPT_COMMAND='history -a'
    ;;
esac

# Less options:
#
# -e: quit at EOF
# -r: raw control characters (makes git diff work)
# -X: disables sending termcap init/deinit strings

export LESS="-erX"

# Some Linuxes I use set SSH_ASKPASS=x11-ssh-askpass. No thanks.
unset SSH_ASKPASS

# ----------------------------------------------------------------------
# Simple shell functions.

# Sum a column of numbers.
function sumcol {
    awk "{sum += \$$1} END {print sum}"
}

# ----------------------------------------------------------------------
# Editor setup.

export EDITOR="emacs -nw"
export SVN_EDITOR="emacs -nw"

# ----------------------------------------------------------------------
# Host specific setup.

if [ "$HOSTNAME" == "esclin3" ]; then
    export ECN_CONNECT_UPSTREAM=1
    export MQSERIES_HOME=/opt/mqm
    export ECN_ENVIRONMENT=ecrampton_bzx
    export DISTCC_HOSTS="ltb7/4 ltb8/4 localhost/6"
    export PATH=/opt/distcc/masq:/opt/distcc/bin:$PATH
    export ECN_ROOT=/opt/ecn/users/$ECN_ENVIRONMENT
    export ECN_USE_GET_PARAM=True
    export LD_LIBRARY_PATH=$ECN_ROOT/bin:$MQSERIES_HOME/lib64:/opt/boost/lib:/opt/tsa/lib:$LD_LIBRARY_PATH
    export COVFILE=$HOME/cpp/bats.cov

    alias bsql='/home/ecrampton/scripts/bsql.sh'
fi

# ----------------------------------------------------------------------
# Local software setup which exists on some of my hosts.

function add_software {
    ROOT=$HOME/software/$1

    if [ -d "$ROOT" ]; then
        if [ -d "$ROOT/bin" ]; then
            export PATH=$PATH:$ROOT/bin
        fi

        if [ -d "$ROOT/share/man" ]; then
            export MANPATH=$MANPATH:$ROOT/share/man
        fi

        if [ -d "$ROOT/lib" ]; then
            export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ROOT/lib
        fi

        if [ -d "$ROOT/lib64" ]; then
            export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ROOT/lib64
        fi
    fi
}

add_software bullseye
add_software conky
add_software git
add_software herbstluftwm
add_software tmux
add_software apache-maven
add_software sbt
add_software scala

export M2_HOME=$HOME/software/apache-maven

if [ -d $HOME/software/dmenu ]; then
    export PATH=$PATH:$HOME/software/dmenu
fi

if [ -d /usr/java/latest ]; then
    export JAVA_HOME=/usr/java/latest
    export PATH=$JAVA_HOME/bin:$PATH
fi
