# Taşınabilir Zsh kurulumu. HyDE gerektirmez.
export ZSH="$HOME/.oh-my-zsh"

if command -v starship >/dev/null 2>&1; then
    ZSH_THEME=""
else
    ZSH_THEME="robbyrussell"
fi

plugins=(git sudo zsh-256color zsh-autosuggestions zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY HIST_IGNORE_DUPS INTERACTIVE_COMMENTS

for config in "$ZDOTDIR/functions/"*.zsh(N); do
    if [[ "$config" == */fzf.zsh ]] && ! command -v fzf >/dev/null 2>&1; then
        continue
    fi
    source "$config"
done

[[ -r "$ZDOTDIR/user.zsh" ]] && source "$ZDOTDIR/user.zsh"
