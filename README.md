# dotfiles
Collection of personal dotfiles and configurations scripts for running my System

setup:

Distro: KDE Neon

Window manager: i3wm, polybar

Terminal: kitty with zsh, tmux, starship

app launcher: Rofi

editor: neovim

pdf viewer: zathura

notifications: dunst

# Scripts
## Tmux related
- battery value display in tmux

## i3/dunst/rofi
- battery notification for 20, 15 and 10% battery life left
- pdf finder to open any pdf from my uni directory straight in zathura from rofi

## Course Management
- MarkDown PreProcessor, CLI tool to quickly convert markdown files in the obsidian flavour to something pandoc can work with
	- This tool mainly exists to improve compatability in my workflow between Obsidian (used for notes and syncing files between linux system and ipad) and a latex compiled pdf for handins of assignments and such
	- Currently written in Python but the code is not great. Should be converted to potentially Rust or Haskell if I can find the time
- note, small script to launch my note taking setup (neovim + zathura with compile upon bufwrite)
- tulok, small applications to quickly access the notes folders (inside the obsidian vault) and the other course files (located on my home drive). Rewrite in Rust with a TUI at some point but don't have time right now

- To be added: 
	- tool to quickly compile lecture notes from a specific course
