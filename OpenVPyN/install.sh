#!/bin/bash
sudo apt install python3 python3-pip python-tk python3-tk openvpn
sudo pip3 install requests pyinstaller
git clone https://github.com/MikMuellerDev/LinuxStuff
# shellcheck disable=SC2164
cd LinuxStuff/OpenVPyN/
chmod +x main.py
pyinstaller main.py --onedir
sudo rm -R __pycache__
sudo rm -R build
sudo rm .gitignore
sudo rm main.spec
sudo rm README.md
sudo mv dist/main ./
sudo rm -R dist
sudo mv icon.png main/
sudo mv SECRETSDEMO.py main/
sudo rm main.py
sudo rm install.sh
