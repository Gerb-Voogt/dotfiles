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
        selected=$(find $1 -type d -not -path "*/.git/*" | fzf)
    else
        selected=$(find ./ -type d -not -path "*/.git/*" | fzf)
    fi

    if [[ -n $selected ]]; then
        cd $selected
    fi
}

# Function to quickly view and open notes without leaving a bunch of pdf files floating around
peek () {
	if [[ "$1" == *.md ]] && [[ -f "$1" ]]; then
		pdf_name=$(echo "$1" | sed "s/md/pdf/")
		current_path=$(pwd)
		notec $1 && zathura $pdf_name && rm -rf $pdf_name
	else 
		echo "Not a markdown file!"
		return
	fi
}

# Custom aliases
alias matlab-cli='/home/gerben/.local/bin/matlab -nodesktop -softwareopengl -nosplash'
alias cp-pwd='pwd | xclip -selection clipboard'
alias ctc='xclip -selection clipboard'
alias vim="nvim"

export LC_ALL=C; unset LANGUAGE

export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/gerben/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/gerben/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<
