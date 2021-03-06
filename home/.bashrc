# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
[ $BASH_VERSINFO -ge 4 ] && shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

export EDITOR=vim

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Use local bin path
export PATH="$HOME/bin:$PATH"

export PS1="\u@\h\[$(tput setaf 4)\] \w \$\[$(tput sgr0)\] "
[ -f $HOME/.bash_color ] &&  PS1="\[$(. $HOME/.bash_color)\]$PS1"

# This seems to only work in screen?
[ "$TERM" == "screen" ] && export PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\ek%s\e\\" $(basename "$(pwd)")'
# For perl local::lib
if [ -e $HOME/perl5/lib/perl5 ] && perl -I$HOME/perl5/lib/perl5 -Mlocal::lib -e1 2>/dev/null; then
    eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
fi

[ -f "$HOME/.homesick/repos/homeshick/homeshick.sh" ] && source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# keychain
if which keychain &>/dev/null; then
    eval `keychain --eval`
fi

# autoreload
_LAST_CHECK=`date +%s`
__reload_bashrc() {
    CHECK_FILES=".bashrc .bashrc.local .bash_aliases"
    for f in $CHECK_FILES; do
        [ -f $HOME/$f ] && [ `date +%s -r $HOME/$f` -ge $_LAST_CHECK ] && . $HOME/$f
    done
    _LAST_CHECK=`date +%s`
}
PROMPT_COMMAND="$PROMPT_COMMAND;__reload_bashrc"

# local modifications (i.e., on a per-host basis)
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
