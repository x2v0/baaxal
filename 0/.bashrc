#!/bin/bash

set +h
umask 022

# Set up environment variables
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=micro

# Set PATH
export PATH=/usr/bin:/usr/sbin:/usr/local/bin${PATH:+:${PATH}}
if [ ! -L /bin ]; then
    export PATH=/bin:$PATH
fi

# History settings
export HISTSIZE=1000
export HISTFILESIZE=2000

# Make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Source bash aliases if the file exists
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Add user's private bin to PATH if it exists
if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
fi

# Source setenv.sh if it exists and thisroot.sh is present
if [ -f ~/setenv.sh ] && [ -f /usr/local/bin/thisroot.sh ]; then
    . ~/setenv.sh
fi

# Source environment variables from Termux-Udocker
if [ -f ~/Termux-Udocker/source.env ]; then
    source ~/Termux-Udocker/source.env
fi

# Customize PS1 prompt
export PS1="\w>"

# Set JAVA_HOME and add OpenJDK to PATH
export JAVA_HOME=$PREFIX/lib/jvm/java-21-openjdk/
export PATH=${PREFIX}/opt/openjdk/bin:${PATH}

# Set Android SDK and tools paths
export ANDROID_SDK_ROOT=${HOME}/android-sdk
export ANDROID_HOME=${HOME}/android-sdk
export PATH=${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${PATH}

# Add custom work directory to PATH
export PATH=$HOME/mywrk:$PATH

# Start SSH daemon (if needed)
if command -v sshd &> /dev/null; then
    sshd
else
    echo "sshd not found. Please install OpenSSH."
fi

# Set Go environment variables
export GOROOT=$PREFIX/lib/go
export GOPATH=$HOME/go
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH

# Add Spack and Cargo to PATH
export PATH=$HOME/wrk/spack-develop/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

# Source forgit plugin
if [ -f $HOME/wrk/forgit/forgit.plugin.sh ]; then
    source $HOME/wrk/forgit/forgit.plugin.sh
fi
