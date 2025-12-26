# If you want to disable instant prompt, do it BEFORE sourcing p10k
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# (Optional) Instant prompt block: if you OFF it, you can remove this entirely.
# If you keep it, keep it at the very top.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="/eww/target/release:$PATH"

# fzf
eval "$(fzf --zsh)"

# thefuck (ONLY ONCE)
eval "$(thefuck --alias fuck)"

# zoxide
eval "$(zoxide init zsh)"

# nvm
source /usr/share/nvm/init-nvm.sh

# powerlevel10k (ONLY ONCE)
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# aliases
alias ls="eza --color=always --long --git --no-permissions --icons=always"
alias speed="speedtest-cli"
alias spot="ncspot"
alias y="yazi"

# fastfetch only in interactive shells, and only once per session
if [[ -o interactive && -z "$FASTFETCH_RAN" ]]; then
  export FASTFETCH_RAN=1
  fastfetch
fi
