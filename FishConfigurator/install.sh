#!/bin/bash

#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run me as root."
  exit 2
fi

apt update
apt upgrade -y
apt install fish


# execute per user on the target system
getent passwd | while IFS=: read -r name _ uid _ _ home shell; do
  if [ -d "$home" ] && [ "$(stat -c %u "$home")" = "$uid" ]; then
    if [ -n "$shell" ] && [ "$shell" != "/bin/false" ] && [ "$shell" != "/usr/sbin/nologin" ]; then
      # add fish to shells
      echo /bin/fish | sudo tee -a /etc/shells

      # set fish as the default
      chsh -s /bin/fish

      # set up fish config
    fi
  fi
done

echo "alias ll='ls -l'" >> "/etc/fish/config.fish"
echo "alias update='sudo apt update && sudo apt upgrade'" >> "/etc/fish/config.fish"
echo "alias btop='bpytop'" >> "/etc/fish/config.fish"
echo "alias bashtop='bpytop'" >> "/etc/fish/config.fish"
echo "alias sss='ssh cloud'" >> "/etc/fish/config.fish"
echo "alias sss='ssh cloud'" >> "/etc/fish/config.fish"
echo "alias poof='poweroff'" >> "/etc/fish/config.fish"
echo "alias 'cd..'='cd ..'" >> "/etc/fish/config.fish"
echo "alias cp='cp -iv'" >> "/etc/fish/config.fish"
echo "alias myip='curl ipinfo.io/ip'" >> "/etc/fish/config.fish"
echo "set fish_greeting" >> "/etc/fish/config.fish"
echo "Successfully installed fish and it's config."