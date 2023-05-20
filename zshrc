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

# Custom shortcuts
bindkey -s '^o' 'nvim $(pf)\n'
bindkey -s '^p' 'insect\n'
bindkey -s '^t' 'tulok\n'
bindkey -s '^g' 'gitui\n'
# bindkey -s '^f' 'fzfcd\n'
bindkey -s '^f' 'cd ~/uni\n fzfcd\n'

# Exports
export BAT_THEME="Catppuccin-mocha"
eval "$(starship init zsh)"

# Custom aliases
alias bat="batcat"
alias ls="exa"
alias pf="fzf --preview 'batcat --color=always --style=numbers --line-range=:500 {}'"
alias la="exa -lH"

[ -f "/home/gerb/.ghcup/env" ] && source "/home/gerb/.ghcup/env" # ghcup-env
