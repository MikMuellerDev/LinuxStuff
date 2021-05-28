#!/bin/bash
sudo apt install python3 python3-pip python-tk python3-tk openvpn
sudo pip3 install requests pyinstaller
git clone https://github.com/MikMuellerDev/LinuxStuff
# shellcheck disable=SC2164
cd LinuxStuff/OpenVPyN/
chmod +x main.py
pyinstaller main.py --onedir

