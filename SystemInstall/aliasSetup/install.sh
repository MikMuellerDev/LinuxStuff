#!/bin/bash

add_alias() { echo -e "alias $1='$2'" >> ~/.config/aliasrc; }

add_alias cl 'clear'
add_alias ll 'ls -l'
add_alias l "ls -l"
add_alias la "ls -lhsa"
add_alias btop 'bpytop'
add_alias bashtop 'bpytop'
add_alias poof 'shutdown -P now'
add_alias 'cd..' 'cd ..'
add_alias cp 'cp -iv'
add_alias myip 'curl ipinfo.io/ip'
add_alias cl 'clear'
add_alias sus 'systemctl suspend'
add_alias rssdm 'sudo systemctl restart sddm'
add_alias lock 'loginctl lock-session'
add_alias setclip 'xclip -selection c'
add_alias getclip 'xclip -selection c -o'
add_alias sss "ssh cloud"
add_alias con "ssh contabo"
add_alias ssp "ssh pi-rack"
add_alias sspr "ssh pi_room"
add_alias ss2 "ssh cloud2"
add_alias ssb "ssh pi_box"
add_alias ping-contabo "ping mik-mueller.de"


perl -i -pe 's/source ~\/\.config\/aliasrc//g' ~/.zshrc
echo "source ~/.config/aliasrc" >> ~/.zshrc