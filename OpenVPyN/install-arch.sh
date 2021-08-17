#!/bin/bash
sudo pacman -S --noconfirm  python python-pip openvpn
sudo pip3 install requests tk
cd /home/$USER/
git clone https://github.com/MikMuellerDev/LinuxStuff
# shellcheck disable=SC2164
cd LinuxStuff/
sudo rm -R .git
rm -R .gitignore
rm -R README.md
# shellcheck disable=SC2164
cd OpenVPyN/
chmod +x main.py
chmod +x remove.sh
chmod +x OpenVpn.desktop
rm .gitignore
rm README.md
sudo mkdir /etc/OpenVPyN/
sudo mv launch.sh /etc/OpenVPyN/
sudo chmod +x /etc/OpenVPyN/launch.sh
sudo cp icon.png /etc/OpenVPyN
# set desktop icon
cp OpenVpn.desktop /home/$USER/.local/share/applications
cd /home/$USER/.local/share/applications
chmod +x OpenVpn.desktop
echo 'created desktop shortcut'
echo "Installed OpenVPyN."
