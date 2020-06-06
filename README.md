# dotfiles

## wiisportsresort

these are cool

### installation links and commands

- i3-gaps: <https://github.com/Airblader/i3>
- picom: <https://github.com/ibhagwan/picom>
- polybar: <https://github.com/polybar/polybar>
- polybar-themes: <https://github.com/adi1090x/polybar-themes>
- ohmyzsh: `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

#### dependencies (probably missed some but oh well)
```zsh
sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev \
  libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev \
  libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev \
  libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev \
  libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev pkg-config \
  libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev4 \
  libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev \
  libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev \
  libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev \
  libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev \
  libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf \
  libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev build-essential git cmake cmake-data \
  pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev \
  libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev \
  libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev \
  libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev \
  asciidoc
```

##### everything else:
```zsh
# normal things
sudo apt install zsh rofi stow pulseeffects lsp-plugins cantata mpd \
  mpc qt5-style-plugins flameshot feh xclip vim ubuntu-make nethogs \
  gnome-tweaks tmux lsyncd dconf-editor fonts-firacode fonts-powerline \
  sl

# firefox dev
umake web firefox-dev

# micro
(curl "https://getmic.ro" | bash) && sudo mv ./micro /usr/bin/micro

# oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting & \
git clone https://github.com/zsh-users/zsh-completions.git \
  ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions & \
git clone https://github.com/lukechilds/zsh-nvm.git \
  ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-nvm

# symlink config
stow i3-gaps rofi ...
```

##### other things
- edit `/usr/share/applicatoins/cantata.desktop` and replace `Exec` with `cantata -style adwaita-dark`
