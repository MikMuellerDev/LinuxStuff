#!/bin/bash

_COLOR () { echo "\\033[38;5;$1m"; }
BOLD () { if [ "$1" != "" ]; then echo "$(BOLD)$(_COLOR "$1")"; else echo "\\033[1m"; fi; }
NORMAL () { if [ "$1" != "" ]; then echo "$(NORMAL)$(_COLOR "$1")"; else echo "\\033[22m"; fi; }
RESET () { echo "\\033[0m"; }

if [ "$EUID" -eq 0 ]; then
  echo -e "$(BOLD 1)Please do not run this script as root$(RESET)"
  exit 1
fi

install () {
  for package in "$@"; do
    pacman -Qi "$package" > /dev/null || sudo pacman -S "$package" --noconfirm || exit 1
  done
}

echo -e "$(NORMAL 6)Installing JetBrains Mono font$(RESET)"
if ( pacman --version > /dev/null ); then
  install ttf-jetbrains-mono
  echo -e "$(NORMAL 2)..done$(RESET)"
else
  echo -e "$(BOLD 1)pacman not found!$(NORMAL) apt is not yet supported. Continuing without font installation$(RESET)"
fi

echo -e "$(NORMAL 6)Installing terminator$(RESET)"
terminator --version || sudo apt install terminator -y || install terminator || exit 2
echo -e "$(NORMAL 2)..done$(RESET)"


echo -e "$(NORMAL 6)Installing terminator config file$(RESET)"
mkdir -p ~/.config/terminator || exit 3
wget -O- https://raw.githubusercontent.com/MikMuellerDev/LinuxStuff/main/SystemInstall/terminatorSetup/config > ~/.config/terminator/config || exit 3
echo -e "$(NORMAL 2)..done$(RESET)"


echo -e "$(NORMAL 6)Downloading forceblur KWin script$(RESET)"
wget -O- "https://github.com/esjeon/kwin-forceblur/releases/download/v0.4.1/forceblur-0.4.1.kwinscript" > ~/forceblur.kwinscript || exit 4
echo -e "$(NORMAL 6)Installing script$(RESET)"
plasmapkg2 -i ~/forceblur.kwinscript || plasmapkg2 -u ~/forceblur.kwinscript || exit 4
rm ~/forceblur.kwinscript
mkdir -p ~/.local/share/kservices5/
cp ~/.local/share/kwin/scripts/forceblur/metadata.desktop ~/.local/share/kservices5/forceblur.desktop || exit 4
echo -e "$(NORMAL 6)Configuring script$(RESET)"
echo -e "\n[Script-forceblur]\npatterns=yakuake\\\nurxvt\\\nkeepassxc\\\nterminator" >> ~/.config/kwinrc || exit 4
echo -e "$(NORMAL 6)Disabling script$(RESET)"
echo -e "\n[Plugins]\nforceblurEnabled=true" >> ~/.config/kwinrc || exit 4
echo -e "$(NORMAL 6)Reloading KWin$(RESET)"
qdbus org.kde.KWin /KWin reconfigure
echo -e "$(NORMAL 6)Enabling script$(RESET)"
perl -i -p -e 's/forceblurEnabled=false/forceblurEnabled=true/' ~/.config/kwinrc || exit 4
echo -e "$(NORMAL 6)Reloading KWin$(RESET)"
qdbus org.kde.KWin /KWin reconfigure
echo -e "$(NORMAL 2)..done$(RESET)"

echo -e "\n$(NORMAL 2)Installation of terminator with blur finished!$(RESET)"
