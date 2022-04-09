#!/bin/bash
set -euo pipefail
# Uncomment for more detailed debugging
# set -x

workBoard() {
  now=$(date +%y-%m-%d) 
  yest=$(date -v -1d +%y-%m-%d)
  if [ -f ~/Documents/Notes/Work/$now.md ]
    then taskell ~/Documents/Notes/Work/$now.md
    else 
      printf '\nCreating board...\n\n'
      if [ -f ~/Documents/Notes/Work/$yest.md ]
        then cp  ~/Documents/Notes/Work/$yest.md ~/Documents/Notes/Work/$now.md
        else cp ~/Documents/Notes/Templates/kanban\ template.md ~/Documents/Notes/Work/$now.md 
      fi
  fi
}

personalBoard() {
  taskell ~/Documents/Notes/todo.md
}

openBoard() {
  if [ $1 == "work" ]
    then workBoard && export KBLAST=$1;
    exit
  fi
  if [ $1 == "personal" ]
    then personalBoard && export KBLAST=$1;
    exit
  fi
  workBoard
  exit
}

while getopts pw flag
do
  case "${flag}" in
    p) openBoard "personal";;
    w) openBoard "work";;
  esac
done

# Add last board option
openBoard "work"