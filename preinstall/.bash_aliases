#!/bin/bash

# Virtualenv aliases
alias ve='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'

# List directory aliases
alias ll='ls -a -t -1'
alias lll='ls -lha'
alias la='ls -A'
alias lh='ls -d .?*'
alias l='ls -a'
alias lsz='ls --human-readable --size -1 -S --classify'

# Mount and disk usage aliases
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | grep -E ^/dev/ | sort"
alias dus='du -sh * | sort -h'

# System update alias
alias updg='apt update && apt upgrade'

# General aliases
alias ed='mcedit'
alias py='python'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'

# Network and IP alias
alias ipls="curl -s ipinfo.io/ip"

# Grep aliases
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Directory and file management aliases
alias mkdir='mkdir -pv'
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'
alias mv='mv -i'
#alias cp='cp -i'
alias ln='ln -i'
alias tkn="cat ~/mywrk/token.txt"

# Process and system monitoring aliases
alias ps="ps ax | sed -e 's#/data/data/com.termux/files##g' | fzf"
alias wget='wget -c'
alias df='df -H | column -t | fzf'
alias du='du -ch'
alias free='free -h | column -t | fzf'

# Git aliases
alias gs="git status -sb"
alias gl="git log"
alias gA="git add -A"
alias ga="git add ."
alias gca="git commit -a"
alias gc="git commit -m"
alias gchk="git checkout"
alias gsh='git stash'
alias gw='git whatchanged'
alias glg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Custom script aliases
alias pdg='cat ~/mywrk/token.txt; ~/mywrk/pdg.sh'
alias gpps='cat ~/mywrk/token.txt; ~/mywrk/gpps.sh'

# FZF aliases
alias fcd='`__fzf_cd__`'
alias fq='fzf -q'

# Custom functions
fnd() {
  find "$1" -name "$2" -type f ! -path "*/.*" | fzf
}

alias fixsh="sed -i '1i\#fix'"
alias fixcs="sed -i '1i\//fix'"

# Source FZF completion and key bindings
source $PREFIX/share/fzf/completion.bash
source $PREFIX/share/fzf/key-bindings.bash

# Code-server alias
alias code='code-server | lt --port 8080 --subdomain onuchinv &'

# Custom directory alias
alias my='cd ~/mywrk'

alias unRO='chmod -R u+w'

# Safe rm function
rm() {
    # Check if the -f flag is present in the arguments
    if echo "$*" | grep -q -- '-f'; then
        # If -f is present, bypass the -i flag and run rm directly
        /bin/rm "$@"
    else
        # Otherwise, run rm with -i for safety
        /bin/rm -i "$@"
    fi
}

alias mygo='cd ~/go/wrk'
alias ds="source ~/mywrk/ds.sh"
