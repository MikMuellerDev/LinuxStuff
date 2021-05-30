#!/bin/bash

echo 'Installing Orchis-Theme | Orchis-Kde | Tela Circle Icon Pack'
# install "kvantum" manager and install git
sudo apt install kvantum-qt5 git -y

# create and cd into a temporary folder
mkdir -p ~/Orchis
cd ~/Orchis || exit 2

# clone Orchis-Theme and install green variant
git clone https://github.com/vinceliuice/Orchis-theme || exit 3
Orchis-theme/install.sh -t green || exit 3

# clone Orchis-Kde and install it
git clone https://github.com/vinceliuice/Orchis-kde || exit 4
Orchis-kde/install.sh || exit 4
sudo Orchis-kde/sddm/install.sh || exit 4

# clone Tela Circle icon pack and install all colors
git clone https://github.com/vinceliuice/Tela-circle-icon-theme || exit 5
Tela-circle-icon-theme/install.sh -a || exit 5

cd || exit 6
rm -rf ~/Orchis || exit 6
echo 'Installed Orchis-Theme | Orchis-Kde | Tela Circle Icon Pack'
echo 'Make sure to select the themes in kvantum and system settings'
echo 'Consider selecting the icon pack in system settings'