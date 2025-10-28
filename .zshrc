export PATH=$PATH:~/bin
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
export PATH="$PATH:$(npm get prefix -g)/bin/"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$HOME/.rbenv/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

plugins=(git)
export EDITOR='nvim'
export ZSH_THEME="agnostom"

RANGER_LOAD_DEFAULT_RC=false
# Zai: Private Go Github modules
export GONOSUMDB="github.com/applatform/*"

source $ZSH/oh-my-zsh.sh

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore node_modules -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--bind ctrl-b:preview-up,ctrl-f:preview-down --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' --color=fg:-1,bg:-1,hl:-1 --color=fg+:-1,bg+:-1,hl+:-1"
eval "$(fzf --zsh)"
source /usr/local/Cellar/fzf/*/shell/key-bindings.zsh
source /usr/local/Cellar/fzf/*/shell/completion.zsh
