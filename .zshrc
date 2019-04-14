export PATH=$PATH:H/bin:/usr/local/bin:/Users/nicho/bin:/Users/nicho/.gem/ruby/2.3.0/bin:/Users/nicho/Library/Python/2.7/bin:$HOME/.cargo/bin
export ZSH="/Users/nicho/.oh-my-zsh"
export LANG=en_US.UTF-8
export EDITOR=nvim

ZSH_THEME="agnoster"
plugins=(git osx vi-mode tmux tmuxinator colored-man-pages)

source $ZSH/oh-my-zsh.sh

alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
