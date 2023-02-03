export PATH=$PATH:~/bin
export ZSH="$HOME/.oh-my-zsh"

# Themes
export ZSH_THEME="agnostom"

# Plugins
plugins=(git)

# Preferred editor
export EDITOR='nvim'

export FZF_DEFAULT_COMMAND="ag -i --hidden --ignore .git -g ''"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--preview-window 'up,60%,border-bottom,+{2}+3/3,~3'"

source $ZSH/oh-my-zsh.sh
# For some reason, this breaks if you put it before sourcing oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh;
