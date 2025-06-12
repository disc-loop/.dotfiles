# Aliases
alias vi='$EDITOR'
alias vimrc='$EDITOR $DOTFILES/.vimrc'
alias zshrc='$EDITOR ~/.zshrc'
alias ohmyzsh='$EDITOR ~/.oh-my-zsh'
alias zshenv='$EDITOR ~/.zshenv'
alias so="source ~/.zshrc"
alias py="python3"
alias learn='lrn() { learnDir=~/Programming/learnxinyminutes-docs/; git -C $learnDir pull && glow -p $learnDir"$1"*.markdown }; lrn'
alias kb="$EDITOR '$WORKNOTES/Kanban.md'"
alias rg="ranger"
alias theme='$EDITOR $DOTFILES/agnostom.zsh-theme'
alias decode='dec() { pbpaste | base64 -d | jq }; dec'
alias pdp1170="ssh pi@192.168.0.212"
alias vd="vd --theme=asciimono"

# Portable utilites
alias cd='changeDir() { export PREVIOUS_DIR=$(pwd); cd $1 }; changeDir'
alias cb='cd $PREVIOUS_DIR'
alias ff='findFiles() { find . \( -path "*/node_modules" -o -path "*/.git" \) -prune -o -type f -iname $1 -print }; findFiles'
alias ffa='findFiles() { find . -type f -iname $1 }; findFiles'
findRefs() {
  pattern=$1
  ops=$2
  dir=$3
  find ${dir:-.} \( -path "*/node_modules" -o -path "*/.git" \) -prune -o -type f -iname \* -exec grep ${ops:--H} $pattern {} \;
};
alias fr='findRefs'
alias fra='findRefs() { grep -rH $1 }; findRefs'
alias fd='findDir() { find . \( -path "*/node_modules" -o -path "*/.git" \) -prune -o -type d -iname $1 -print }; findDir'
alias fda='findDir() { find . -type d -iname $1 }; findDir'

# Global variables
export SLIPBOX="$HOME/Documents/Slip Box"
export WORKNOTES="$SLIPBOX/Work/Notes"
export PERSONALNOTES="$SLIPBOX/Projects/Quotidian.md"
export DOTFILES="$HOME/.dotfiles"

# Zai specific
alias aws-login='aws-login-fn() { export AWS_PROFILE="$1"; app-aws-login.py $AWS_PROFILE }; aws-login-fn'
alias aws-logout='AWS_PROFILE=""; rm ~/.aws/credentials'
alias rfl='$EDITOR $SLIPBOX/Projects/Work/Reflections/$(date +"%Y-%m-%d").md'
alias get-im-url-for='getUrl() { branch=$1; dns_record=$(aws cloudformation describe-stack-resource --stack-name ironman-dev-$branch-api --logical-resource-id InternalDNSAliasRecord | jq -r ".StackResourceDetail.PhysicalResourceId"); echo -n "https://$dns_record" | pbcopy; }; getUrl'
alias get-im-nonprod-vals='aws ssm get-parameters --names "/apps/npp/nonprod/ironman_username" "/apps/npp/nonprod/ironman_password" "/apps/payid/dev/ironman_url" --with-decryption | jq'
get-va-db-fn() {
  stage=$1 # dev, prelive, or prod
  namespace=$2
  type=$3 # WRITER or READER
  host=$(aws rds describe-db-cluster-endpoints --query "DBClusterEndpoints[?contains(DBClusterIdentifier, 'virtual-accounts-${stage}-${namespace}-data-rds') && contains(EndpointType, '${type}')].Endpoint" | jq '.[0]' | tr -d '\n' | tr -d '"')
  username=$(aws ssm get-parameter --with-decryption --name /apps/virtual-accounts/${stage}/rds_username | jq '.Parameter.Value' | tr -d '\n' | tr -d '"')
  password=$(aws ssm get-parameter --with-decryption --name /apps/virtual-accounts/${stage}/rds_password | jq '.Parameter.Value' | tr -d '\n' | tr -d '"')
  echo mysql -h ${host} -P 3306 -u ${username} -p${password} -D virtual_accounts_database
}
alias get-va-db='get-va-db-fn'
