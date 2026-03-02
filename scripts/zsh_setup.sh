ZSHRC="$HOME/.zshrc"
ZSHENV="$HOME/.zshenv"

echo "Creating .zshrc with p10k and rice integration"

cat <<EOF > "$ZSHRC"
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
if [[ -r "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh" ]]; then
  source "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh"
fi

[[ -f ~/.config/zsh/rice.zsh ]] && source ~/.config/zsh/rice.zsh

# You can put any zsh config here

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
EOF

echo ".zshrc has been regenerated"

echo "Creating .zshenv"

cat <<EOF > "$ZSHENV"
[[ -f ~/.config/zsh/env.zsh ]] && source ~/.config/zsh/env.zsh
EOF

echo ".zshenv has been regenerated"
