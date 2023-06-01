# ~/.profile: executed by the command interpreter for login shells.

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

# Custom function for fuzzy finding and CDing to folders
fzfcd() {
    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        selected=$(find ~/uni -type d -not -path "*/.git/*" | fzf)
    fi

    if [[ -n $selected ]]; then
        cd $selected
    fi
}

# Custom aliases
alias matlab='~/Local/Matlab_R2022a/bin/matlab -nodesktop -softwareopengl -nosplash'
alias cp-pwd='pwd | xclip -selection clipboard'
alias ctc='xclip -selection clipboard'
alias vim="nvim"
alias v="nvim"
