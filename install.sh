#!/bin/bash
set -e
echo "==> Installing required packages."
sudo pacman -Sy --needed --noconfirm \
  niri waybar fuzzel kitty matugen swaybg xwayland-satellite pipewire pipewire-pulse wireplumber pavucontrol \
  network-manager-applet xdg-desktop-portal-gnome xdg-desktop-portal-gtk lxqt-policykit swaync cliphist \
  swayidle swaylock adw-gtk-theme tela-circle-icon-theme-blue nautilus file-roller poppler tumbler \
  ffmpegthumbnailer stow curl imagemagick neovim firefox fastfetch base-devel git flatpak fuse2 \
  ttf-firacode-nerd noto-fonts noto-fonts-emoji noto-fonts-cjk ffmpeg gst-plugins-base gst-plugins-good \
  gst-plugins-bad gst-plugins-ugly gst-libav btop bash-completion zip unzip 7zip unrar brightnessctl \
  starship udiskie qt5ct qt6ct qt5-wayland qt6-wayland kvantum kvantum-qt5
echo "==> Adding the Flathub repository to your user."
flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo "==> Backing up user files."
BACKUP_DIR=~/Backups/$(date +%Y%m%d_%H%M%S)
mkdir -p "$BACKUP_DIR"
if [ -f ~/.bashrc ]; then
  mv ~/.bashrc "$BACKUP_DIR"
fi
if [ -f ~/.icons/default/index.theme ]; then
  mv ~/.icons/default/index.theme "$BACKUP_DIR"
fi
if [ -f ~/Pictures/Wallpapers/Wallpaper.png ]; then
  mv ~/Pictures/Wallpapers/Wallpaper.png "$BACKUP_DIR"
fi
mv ~/.config/* "$BACKUP_DIR"
mkdir -p ~/.local/share/icons
mkdir -p ~/.cache/install-temp
if [ ! -d ~/.local/share/icons/Bibata-Modern-Classic ]; then
  echo "==> Installing the Bibata Modern Classic cursor."
  curl -sfL https://github.com/ful1e5/Bibata_Cursor/releases/latest/download/Bibata-Modern-Classic.tar.xz -o ~/.cache/install-temp/Bibata-Modern-Classic.tar.xz
  tar -xf ~/.cache/install-temp/Bibata-Modern-Classic.tar.xz -C ~/.local/share/icons
  rm -rf ~/.cache/install-temp/Bibata-Modern-Classic.tar.xz
else
  echo "==> Bibata Modern Classic is already installed."
fi
echo "==> Installing LazyVim for Neovim."
if [ -f ~/.config/nvim/init.lua ]; then
  mv ~/.config/nvim{,.bak}
fi
git clone https://github.com/LazyVim/starter --depth=1 ~/.config/nvim
rm -rf ~/.config/nvim/.git
echo "==> Configuring Matugen in Neovim."
grep -qF 'require("config.matugen")' ~/.config/nvim/init.lua ||
  echo 'require("config.matugen")' >>~/.config/nvim/init.lua
echo "==> Stowing Dotfiles"
cd ~/NiriDotfiles/
stow \
  bash fastfetch fuzzel gtk indextheme kdeglobals kitty Kvantum matugen niri nvim nvim-kitty qtct swaync wallpaper \
  waybar xdg-desktop-portal
cd ~
echo "==> Applying the themes."
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-blue-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Classic'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
flatpak install --user -y org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
echo "==> Setting the default file manager."
xdg-mime default org.gnome.Nautilus.desktop inode/directory
if [ -f "$HOME/Pictures/Wallpapers/Wallpaper.png" ]; then
  echo "==> Generating Matugen themes."
  matugen image "$HOME/Pictures/Wallpapers/Wallpaper.png"
else
  echo "==> No wallpaper; skipping the Matugen theme generation."
fi
echo "Removing temporary installation folder."
rm -rf ~/.cache/install-temp
echo "Installation complete."
