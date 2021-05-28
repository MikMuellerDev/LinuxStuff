#!/bin/bash
sudo apt install python3 python3-pip python-tk python3-tk openvpn
sudo pip3 install requests
git clone https://github.com/MikMuellerDev/LinuxStuff
# shellcheck disable=SC2164
cd LinuxStuff/
sudo rm -R .git
sudo rm -R .gitignore
sudo rm -R README.md
# shellcheck disable=SC2164
cd OpenVPyN/
chmod +x main.py
sudo rm .gitignore
sudo rm README.md
echo "Installed OpenVPyN."
sudo chmod +x main.py
./main.py &&
