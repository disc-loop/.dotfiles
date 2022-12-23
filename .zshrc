export PATH=$PATH:~/bin
export ZSH="$HOME/.oh-my-zsh"

# Themes
export ZSH_THEME="agnostom"

# Plugins
plugins=(git)

# Preferred editor
export EDITOR='vim'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh;
export FZF_DEFAULT_COMMAND="ag --hidden --ignore .git -g ''"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--preview-window 'up,60%,border-bottom,+{2}+3/3,~3'"

source $ZSH/oh-my-zsh.sh
