# Aliases
alias pdp1170="ssh pi@192.168.0.212"
alias dotfiles="cd ~/.vim/VimConfig/"
alias vi='nvim'
alias so="source ~/.zshrc"
alias py="python3"
alias learn='lrn() { learnDir=~/Programming/learnxinyminutes-docs/; git -C $learnDir pull && glow -p $learnDir"$1"*.markdown }; lrn'
alias kb="nvim '$WORKNOTES/Kanban.md'"
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias rg="ranger"
alias decode='dec() { pbpaste | base64 -d | jq }; dec'
alias jira='cat ~/Documents/Slip\ Box/Projects/Work/Templates/JIRA\ Ticket\ Template.md | pbcopy; echo Copied JIRA template to clipboard'
alias zshenv='vi ~/.zshenv'
alias aws-login='aws-login-fn() { export AWS_PROFILE="$1"; app-aws-login.py $AWS_PROFILE }; aws-login-fn'
alias aws-logout='AWS_PROFILE=""; rm ~/.aws/credentials'
alias rfl='vi $SLIPBOX/Projects/Work/Reflections/$(date +"%Y-%m-%d").md'
alias get-nonprod-im-vals='aws ssm get-parameters --names "/apps/npp/nonprod/ironman_username" "/apps/npp/nonprod/ironman_password" "/apps/payid/dev/ironman_url" --with-decryption | jq'

# Portable utilites
alias ff='findFiles() { find . \( -path "*/node_modules" -o -path "*/.git" \) -prune -o -type f -iname $1 -print }; findFiles'
alias ffa='findFiles() { find . -type f -iname $1 }; findFiles'
alias fr='findRefs() { find . \( -path "*/node_modules" -o -path "*/.git" \) -prune -o -type f -iname \* -exec grep -H $1 {} \; }; findRefs'
alias fra='findRefs() { grep -rH $1 }; findRefs'
alias fd='findDir() { find . \( -path "*/node_modules" -o -path "*/.git" \) -prune -o -type d -iname $1 -print }; findDir'
alias fda='findDir() { find . -type d -iname $1 }; findDir'

# Global variables
export SLIPBOX="$HOME/Documents/Slip Box"
export WORKNOTES="$SLIPBOX/Projects/Work/Notes"
export PERSONALNOTES="$SLIPBOX/Projects/Quotidian.md"
export DOTFILES="$HOME/.dotfiles"
