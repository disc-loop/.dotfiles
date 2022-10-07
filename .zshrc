#ZSH_DISABLE_COMPFIX="true"
export "PATH=/usr/local/Cellar/postgresql@9.6/9.6.20/bin:${PATH}"
export PATH=$PATH:~/bin

# If you come from bash you might have to change your $PATH.

# Jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Golang exports export GOPATH=$HOME/go export PATH=$PATH:$GOPATH/bin 
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin
export GOPRIVATE=scm.applatform.io

# Path to your oh-my-zsh installation.
export ZSH="/Users/thomasjones/.oh-my-zsh"

# Themes
ZSH_THEME="agnostom"

# Racket
export PATH="/Applications/Racket/bin:$PATH"

# Coursier
export PATH="$PATH:/Users/thomasjones/Library/Application Support/Coursier/bin"

# Plugins
plugins=(git)

# Preferred editor
export EDITOR='vim'

# Other
eval "$(saml2aws --completion-script-zsh)"

# Not sure what this is for
# export NVM_DIR="$HOME/.nvm"
#   [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#   [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# export PATH="/usr/local/opt/mysql-client/bin:$PATH"

source $ZSH/oh-my-zsh.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Keep these things below sourcing of ohmyzsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh;
# export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_COMMAND="ag --hidden --ignore .git -g ''"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--preview-window 'up,60%,border-bottom,+{2}+3/3,~3'"

[ -f "/Users/thomasjones/.ghcup/env" ] && source "/Users/thomasjones/.ghcup/env" # ghcup-env
