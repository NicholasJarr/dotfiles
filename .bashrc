export CLICOLOR=1
export LANG="en_US.UTF-8"

current_branch () {
  if [ -a .git ]; then
    echo "(`git branch | awk '/\*/ { print $2; }'`) "
  else
    echo ''
  fi
}

prompt () {
  if [ $COLUMNS -lt 70 ]; then
    export PS1="\[\e[32m\]\]\w \[\e[31m\]\]`current_branch`\[\e[0m\]\]\n$ "
  else
    export PS1="\[\e[34m\]\]\u@\h \[\e[32m\]\]\w \[\e[31m\]\]`current_branch`\[\e[0m\]\]\n$ "
  fi
}

set -o vi
export EDITOR=nvim
PATH=$PATH:$HOME/Projects/OpenSource/dotfiles/scripts
PROMPT_COMMAND=prompt
