# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'


set bell-style none
ZSH_THEME="robbyrussell"

plugins=(
	# zsh-syntax-highlighting 
	zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

# Start starship
# eval "$(starship init zsh)"

# Custom shortcuts
bindkey -s '^g' 'gitui -t mocha.ron\n'
bindkey -s '^f' 'fzfcd ~/uni\n'
# bindkey -s '^o' 'tmuxifier load-window matlab\n'

# Exports

export PATH="$HOME/.tmuxifier/bin:$PATH"
export NOTES_DIR="/home/gerben/uni/Vault-MSc"
export EDITOR="nvim"
export CPLUS_INCLUDE_PATH=/usr/include/c++/11:/usr/include/x86_64-linux-gnu/c++/11
export LC_TIME="en_GB.utf8"
export ACADOS_INSTALL_DIR="/home/gerben/MATLAB/toolboxes/acados"
export MATLABPATH="/home/gerben/apps/matlabR2023b/bin"

# export DASHT_DOCSETS_DIR="/home/gerb/.local/share/Zeal/Zeal/docsets/"

# Custom aliases
alias ls="exa"
alias la="exa -lH"
alias paim="xclip -selection clipboard -t image/png -o >" # Paste images in terminal
alias tmux="tmux -u"
alias vimdiff="nvim -d"

alias yeet="rm -rf"
alias so="source"

# Needed for Haskell
# [ -f "/home/gerb/.ghcup/env" ] && source "/home/gerb/.ghcup/env" # ghcup-env

## ENABLING THIS MAKES TERMINAL BOOTUP TIME VERY SLOW
# Papis autocomplete
# eval "$(_PAPIS_COMPLETE=zsh_source papis)" 

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/gerben/.juliaup/bin' $path)
export PATH

DOTFILESPATH="$HOME/uni/dotfiles/"
export DOTFILESPATH

# <<< juliaup initialize <<<
# Bind commands for running a julia daemon
alias juliaserver="echo 'Running Julia server!' && julia --startup-file=no -e 'using Revise; using DaemonMode; serve()'"
alias juliaclient='julia --startup-file=no -e "using DaemonMode; runargs()"'

[ -f "/home/gerben/.ghcup/env" ] && source "/home/gerben/.ghcup/env" # ghcup-env

# $DOTFILESPATH/scripts/tmux/haiku

# Export for golang
export PATH=$PATH:/usr/local/go/bin

# Export for Ruby/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
