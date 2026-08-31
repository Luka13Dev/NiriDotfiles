#!/bin/bash

choice=$(printf "Lock\nReboot\nShutdown\nLogout" |
  fuzzel --dmenu)

case "$choice" in
Lock) swaylock --image ~/Imagens/Wallpaper.png ;;
Suspend) systemctl suspend ;;
Reboot) systemctl reboot ;;
Shutdown) systemctl poweroff ;;
Logout) swaymsg exit ;;
esac
