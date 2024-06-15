#!/bin/bash
set -euo pipefail
# Uncomment for more detailed debugging
# set -x

workBoard() {
  now=$(date +%y-%m-%d)
  yest=$(date -v -1d +%y-%m-%d)
  if [ -f "$WORKNOTES/$now.md" ]
    then taskell "$WORKNOTES/$now.md"
    else 
      printf '\nCreating board...\n\n'
      if [ -f "$WORKNOTES/$yest.md" ]
        then cp "$WORKNOTES/$yest.md" "$WORKNOTES/$now.md" && taskell "$WORKNOTES/$now.md"
        else cp "$SLIPBOX/Templates/taskell.md" "$WORKNOTES/$now.md"
      fi
  fi
}

personalBoard() {
  taskell $PERSONALNOTES
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
