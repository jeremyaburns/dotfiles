#.bashrc

# vi mode
set editing-mode vi
set keymap vi
set -o vi
export EDITOR="vim"

# Command aliases
alias l='ls -1aG'
alias grep='grep --color=auto'

# Grep SVN status for a pattern and execute an svn command on the selection.
sg () {
    if [ "$#" -lt 1 ]; then
        svn st
    elif [ "$#" -lt 2 ]; then
        svn st | grep "$1" | awk '{print $2}'
    else
        svn st | grep "$1" | sed 's/^. *//g;s/\(.*\)/"\1"/' | xargs svn "$2"
    fi;
}

# Show the log from HEAD back n revisions
sl () {
    rev=$(svn info | grep 'Revision' | cut -d\  -f2)
    svn log -r "$(expr $rev - $1):HEAD"
}

# Quick alias for editing the ignore list in svn
alias si='svn propedit svn:ignore .'

# Add personal toolbox to path
export PATH=$PATH:/home/jaburns/tools

# Colored prompt with error display
ps1_color_error () {
    if [ "$1" -eq 0 ]; then
        printf '\033[0;32m'
        printf "^_^ "
    else
        printf '\033[0;31m'
        printf "%-4s" "$1"
    fi;
}
export PS1='$(ps1_color_error $?)\u\[\033[0;34m\] \W) \[\033[0m\]'
