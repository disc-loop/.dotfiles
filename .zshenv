# Aliases
alias dotfiles="cd ~/.vim/VimConfig/"
alias so="source ./.zshrc"
alias py="python3"
alias learn='lrn() { learnDir=~/Documents/learnxinyminutes-docs/; git -C $learnDir pull && glow -p $learnDir"$1"*.markdown }; lrn'
alias kb="${HOME}/.dotfiles/kanban.sh"
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias nonprod="app-aws-login.py nonprod"
alias rg="ranger"
alias decode='dec() { echo "$1" | base64 -d | jq }; dec'
