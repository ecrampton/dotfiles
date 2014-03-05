#!/bin/bash
#
# Move onto a new host. This script is idempotent---run it anytime and
# it will only do work that is necessary to get things setup in a
# consistent state.

set -e

# --------------------------------------------------------------------------------
function ensure_symlink {
    source=$1
    dest=$2

    if [[ -h $dest ]]; then
        if [[ $(readlink -n "$dest") != $source ]]; then
            overwrite=y
        fi
    elif [[ -f $dest || -d $dest ]]; then
        overwrite=y
    fi

    if [[ "$overwrite" == "y" ]]; then
        read -p "Overwrite $dest? " answer
    else
        answer=y
    fi

    [[ $answer == y ]] && ln -s -n -f -- "$source" "$dest"
}

# --------------------------------------------------------------------------------
# Setup basic symlinks.

function setup_basic_symlinks {
    cd $HOME
    ensure_symlink dotfiles/bashrc    .bashrc
    ensure_symlink dotfiles/emacs     .emacs
    ensure_symlink dotfiles/Xdefaults .Xdefaults
    
    if [ ! -d ".config/herbstluftwm" ]; then
        mkdir -p .config/herbstluftwm
    fi

    cd .config/herbstluftwm
    ensure_symlink ../../dotfiles/herbstluftwm-autostart autostart
    ensure_symlink ../../dotfiles/herbstluftwm-panel.sh  panel.sh
}

# --------------------------------------------------------------------------------
# Download, byte compile, and install AuC-TeX.

function setup_auctex {
    ROOT=$HOME/software/auctex
    AUCTEX_VERSION=11.87

    if [ -d $HOME/software/auctex ]; then
        return
    fi

    # Fetch and uncompress.
    cd /tmp
    wget http://ftp.gnu.org/pub/gnu/auctex/auctex-${AUCTEX_VERSION}.tar.gz -O /tmp/auctex.tar.gz
    tar xzf auctex.tar.gz
    cd auctex-${AUCTEX_VERSION}
    mkdir -p $HOME/software/auctex-${AUCTEX_VERSION}/texmf

    # Configure.
    ./configure \
        --prefix=$HOME/software/auctex-${AUCTEX_VERSION} \
        --with-lispdir=$HOME/software/auctex-${AUCTEX_VERSION}/site-lisp \
        --with-texmf-dir=$HOME/software/auctex-${AUCTEX_VERSION}/texmf

    # Make and install.
    make && make install

    cd $HOME/software
    ln -s auctex-${AUCTEX_VERSION} auctex

    # Cleanup.
    rm /tmp/auctex.tar.gz
    rm -rf /tmp/auctex-${AUCTEX_VERSION}
}

# --------------------------------------------------------------------------------
# Download and install terminus font.

function setup_terminus_font {
    ROOT=$HOME/software/terminus
    TERMINUS_VERSION=4.38

    if [ -d $HOME/software/terminus-font-${TERMINUS_VERSION} ]; then
        return
    fi

    # Fetch and uncompress.
    cd $HOME/software
    wget "http://softlayer-ams.dl.sourceforge.net/project/terminus-font/terminus-font-${TERMINUS_VERSION}/terminus-font-${TERMINUS_VERSION}.tar.gz" \
        -O terminus.tar.gz
    tar xzf terminus.tar.gz
    
    # Symlink.
    ln -s terminus-font-${TERMINUS_VERSION} terminus-font
    cd terminus
    make && mkfontdir

    # Cleanup.
    cd ..
    rm terminus.tar.gz
}

# --------------------------------------------------------------------------------
# Byte compile all lisp files.

function byte_compile_lisp {
    find $HOME/dotfiles/lisp -name '*.el' -exec \
        emacs -u $USER --batch --eval '(byte-compile-file "{}")' \; >& /dev/null
}

setup_basic_symlinks
setup_auctex
setup_terminus_font
byte_compile_lisp
