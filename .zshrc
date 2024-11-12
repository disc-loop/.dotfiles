export PATH=$PATH:~/bin
export ZSH="$HOME/.oh-my-zsh"

# Aliases: ~/.zshenv

# Themes
export ZSH_THEME="agnostom"

# Plugins
plugins=(git)

# Preferred editor
export EDITOR='nvim'

# Make ranger load local conf
RANGER_LOAD_DEFAULT_RC=false

# Private Go Github modules
export GONOSUMDB="github.com/applatform/*"

# Ruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
# eval "$(rbenv init - zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source $ZSH/oh-my-zsh.sh

# Keep this at the bottom else some of it will fail
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--bind ctrl-b:preview-up,ctrl-f:preview-down --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' --color=fg:-1,bg:-1,hl:-1 --color=fg+:-1,bg+:-1,hl+:-1"
eval "$(fzf --zsh)"
source /usr/local/Cellar/fzf/0.55.0/shell/key-bindings.zsh
source /usr/local/Cellar/fzf/0.55.0/shell/completion.zsh
