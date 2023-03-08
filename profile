# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
. "$HOME/.cargo/env"
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# Set PATH, MANPATH, etc., for Homebrew.
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Custom function for fuzzy finding and CDing to folders
fzfcd() {
if [ $# -eq 0 ]
  then
    cd $(find . -type d -print | fzf)
    
    else
        cd $(find "$1" -type d -print | fzf)
fi
}

# Custom aliases
alias matlab='~/Local/Matlab_R2022a/bin/matlab -nodesktop -softwareopengl -nosplash'
alias cp-pwd='pwd | xclip -selection clipboard'
alias conda='~/anaconda3/bin/conda'
alias anaconda-navigator='~/anaconda3/bin/anaconda-navigator'
alias import-clockify='~/programming/git/NotionIntegration/importClockify.py'
alias ctc='xclip -selection clipboard'
alias v="nvim"

# alias cd-fzf='cd $(find . -type d -print | fzf)'

