#!/bin/bash
set -euo pipefail
# Uncomment for more detailed debugging
# set -x

workBoard() {
  now=$(date +%y-%m-%d) 
  yest=$(date -v -1d +%y-%m-%d)
  if [ -f "$HOME/Documents/Notes/Work/$now.md" ]
    then taskell "$HOME/Documents/Notes/Work/$now.md"
    else 
      printf '\nCreating board...\n\n'
      if [ -f "$HOME/Documents/Notes/Work/$yest.md" ]
        then cp  ~/Documents/Notes/Work/$yest.md ~/Documents/Notes/Work/$now.md && taskell ~/Documents/Notes/Work/$now.md
        else cp ~/Documents/Notes/Templates/Kanban.md ~/Documents/Notes/Work/$now.md 
      fi
  fi
}

personalBoard() {
  taskell ~/Documents/Notes/Tasks/Daily.md
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
