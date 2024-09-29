#!/bin/bash

# Remove symlinked dotfiles installed by stow
cd $HOME/zenities
stow -D .

# Restore the original hypr and kitty configurations (if backups exist)
cd $HOME/.config
if [ -d "hypr.bak" ]; then
    rm -rf hypr
    mv hypr.bak hypr
fi

if [ -d "kitty.bak" ]; then
    rm -rf kitty
    mv kitty.bak kitty
fi

# Remove cloned zenities dotfiles
cd $HOME
rm -rf zenities

# Clean up Eww
# if [ -d "$HOME/eww" ]; then
#     rm -rf $HOME/eww
#     sudo rm /usr/local/bin/eww
# fi

# Restore default shell to bash
chsh -s /bin/bash

# Optionally stop and disable NetworkManager (comment these lines if you want to keep NetworkManager)
# sudo systemctl disable NetworkManager
# sudo systemctl stop NetworkManager

# Reboot the system
echo "Uninstallation complete. The system will now reboot."
sudo reboot

