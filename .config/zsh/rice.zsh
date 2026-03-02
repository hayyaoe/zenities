# Eww Path
export PATH="/eww/target/release:$PATH"

# fzf
eval "$(fzf --zsh)"

# thefuck (ONLY ONCE)
eval "$(thefuck --alias fuck)"

# zoxide
eval "$(zoxide init zsh)"

# nvm
source /usr/share/nvm/init-nvm.sh

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
