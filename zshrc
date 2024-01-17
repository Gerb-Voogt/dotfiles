# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'


set bell-style none
ZSH_THEME=""

plugins=(
	git 
	zsh-syntax-highlighting 
	zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

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


# Custom shortcuts
bindkey -s '^p' 'insect\n'
bindkey -s '^g' 'gitui -t mocha.ron\n'
bindkey -s '^f' 'fzfcd ~/uni\n'
bindkey -s '^M' 'tmuxifier load-window matlab\n'

# Exports
export BAT_THEME="Catppuccin-mocha"
eval "$(starship init zsh)"

export PATH="$HOME/.tmuxifier/bin:$PATH"
export EDITOR="nvim"
export PATH=/usr/local/cuda-12.1/bin${PATH:+:${PATH}} # Setup cuda toolkit
export CPLUS_INCLUDE_PATH=/usr/include/c++/11:/usr/include/x86_64-linux-gnu/c++/11
export DASHT_DOCSETS_DIR="/home/gerb/.local/share/Zeal/Zeal/docsets/"
export LC_TIME="en_GB.utf8"

# Custom aliases
alias bat="batcat"
alias ls="exa"
alias pf="fzf --preview 'batcat --color=always --style=numbers --line-range=:500 {}'"
alias la="exa -lH"
alias paim="xclip -selection clipboard -t image/png -o >"

alias python="python3.12"
alias python3="python3.12"
alias tmux="tmux -u"


[ -f "/home/gerb/.ghcup/env" ] && source "/home/gerb/.ghcup/env" # ghcup-env

eval "$(lesspipe)"  
