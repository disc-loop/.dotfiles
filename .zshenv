# Aliases
alias pdp1170="ssh pi@192.168.0.251"
alias dotfiles="cd ~/.vim/VimConfig/"
alias so="source ./.zshrc"
alias py="python3"
alias learn='lrn() { learnDir=~/Programming/learnxinyminutes-docs/; git -C $learnDir pull && glow -p $learnDir"$1"*.markdown }; lrn'
alias kb="~/kanban.sh"
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias rg="ranger"
alias decode='dec() { echo "$1" | base64 -d | jq }; dec'
