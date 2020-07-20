#!/bin/bash

# colors
bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)

prefix="${bold}${blue}[install]${normal}"

echop() {
  echo "$prefix $@"
}

# zsh
if echo $SHELL | grep -v "zsh"; then
  echop "Installing zsh..."
  sudo pacman -S zsh --needed

  if [[ $? -ne 0 ]]; then
    echop "There was a problem installing zsh. Remedy the error and try again."
    exit 1
  fi

  echop "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  echop "Installing plugins..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/lukechilds/zsh-nvm.git \
    ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-nvm

  echop "Linking config files..."
  mv "$HOME/.zshrc" "$HOME/.zshrc.old"
  rm -rf "$ZSH_CUSTOM/example.zsh"
  # stow zshell i3-gaps xorg rofi picom gtk backgrounds mpd pulse

  echop "${green}Done. Make sure zsh is set as default and then rerun this script from zsh.${normal}"
  exit 0
else
  echop "${yellow}zsh is already installed and set as default, continuing...${normal}"
fi

# micro text editor
read -n1 -rp "$prefix Install micro? [Y/n] " response
echo
response=${response,,} # tolower
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
  echop "Installing micro..."
  (curl "https://getmic.ro" | bash >/dev/null) && sudo mv ./micro /usr/bin/micro
else
  echop "Skipping micro."
fi

echop "Running pacman -Syu..."
sudo pacman -Syu

packagelist="alsa-utils android-udev autokey base base-devel breeze chromium cmake cowsay dconf-editor deja-dup dhcpcd discord duplicity efibootmgr feh figlet firefox-developer-edition flameshot fzwal-git gconf gdm gedit gimp git gitkraken gnome gnome-terminal gnome-tweaks gparted guake htop i3-gaps intel-ucode intellij-idea-community-edition iwd jdk-openjdk jdk11-openjdk jdk8-openjdk konsole krita krita-plugin-gmic libheif libxss linux linux-firmware linux-headers man-db man-pages maven minecraft-launcher mono mpc mpd mplayer mpv nano nautilus neofetch networkmanager obs-studio opencolorio pavucontrol poppler-qt5 powerline-fonts pulseeffects python-pip python-pyqt5 qt5ct refind rofi rsync scrcpy screenkey sl speedtest-cli sqlitebrowser steam stow terminus-font tmux tree ttf-fira-code ttf-roboto ttf-ubuntu-font-family uthash virtualbox virtualbox-host-modules-arch visual-studio-code-insiders vlc wget which wimlib wine-stable xclip xdg-user-dirs-gtk xf86-input-evdev xf86-input-synaptics xf86-video-fbdev xf86-video-vesa xorg zoom"

echop "Installing main packages..."

sudo pacman -S $packagelist --needed


# set up aur installs
doaurinstalls=true

read -n1 -rp "$prefix Install AUR packages? [Y/n] " response
echo
response=${response,,} # tolower
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
  echop "Installing AUR packages..."
  read -ep "$prefix Absolute (or relative to cwd) directory for AUR git clones: " aurdir

  if [ ! -d $aurdir ]; then
    echop "Directory $aurdir doesn't exist, creating it... "
    mkdir -p $aurdir
  fi

  pushd $aurdir

  clone() {
    for pkg in "$@"; do
      echo "$prefix Cloning $pkg..."
      git clone "https://aur.archlinux.org/$pkg.git" >/dev/null
      if [[ $? -eq 0 ]]; then
        pushd $pkg
        echop "Running makepkg -si..."
        makepkg -si
        popd
      else
        echop "${red}Problem cloning $pkg, see above.${normal}"
      fi
    done
    sleep 1
  }

  clone adwaita-qt autokey bitfetch cava ffsend-bin fzwal-git gconf gitkraken i3-gnome minecraft-launcher picom-ibhagwan-git pipes.sh scrcpy screenkey visual-studio-code-insiders xinit-xsession zoom

  read -n1 -rp "$prefix The package wine-stable will take a while to compile, do you want to install it now? [Y/n] " response
  echo
  response=${response,,} # tolower
  if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
    clone wine-stable
  else
    echop "Skipping wine-stable."
  fi

  popd
else
  echop "Skipping AUR packages."
fi

echop "${green}Done! Some more things to do:${normal}"
echop "- edit '/usr/share/applicatoins/cantata.desktop' and replace 'Exec' with 'cantata -style adwaita-dark'"
