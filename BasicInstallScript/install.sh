#!/bin/bash


if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root"
  exit 2
fi

apt update
apt upgrade -y
apt install sudo vim neofetch fish htop curl xclip git openjdk-11-jdk python3.9 python3-pip python3-tk lolcat wget cmatrix fortune cowsay tmux openjfxsnapd speedtest-cli wine figlet tree -y || exit 1

pip3 install bpytop openpyxl requests apscheduler --upgrade

# Install bat
curl -L -o ~/bat_0.18.0_amd64.deb https://github.com/sharkdp/bat/releases/download/v0.18.0/bat_0.18.0_amd64.deb
dpkg -i ~/bat_0.18.0_amd64.deb
rm ~/bat_0.18.0_amd64.deb

# Execute per user
getent passwd | while IFS=: read -r name _ uid _ _ home shell; do # name password uid gid gecos home shell
  if [ -d "$home" ] && [ "$(stat -c %u "$home")" = "$uid" ]; then
    if [ -n "$shell" ] && [ "$shell" != "/bin/false" ] && [ "$shell" != "/usr/sbin/nologin" ]; then
      # If not root
      if [ "$uid" -ne 0 ]; then
        # Install fish
          sudo bash -c "(wget -O- https://raw.githubusercontent.com/MikMuellerDev/LinuxStuff/main/FishConfigurator/install.sh | bash)"

        # Install OpenVPyN
          wget -O- https://raw.githubusercontent.com/MikMuellerDev/LinuxStuff/main/OpenVPyN/install.sh | bash
      fi

      # Install SpaceVim
      su -c "curl -sLf https://spacevim.org/install.sh | bash" "$name"
    fi
  fi
done