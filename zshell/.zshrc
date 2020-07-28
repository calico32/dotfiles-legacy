# colors
bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)

# ====================================================================
# env

typeset -U path

path=(
  "$HOME/.bin"
  "node_modules/.bin"
  "$HOME/.local/bin"
  "$HOME/.flutter-sdk/bin"
  "$HOME/.android/sdk/platform-tools"
  "$HOME/.go/bin"
  "/usr/local/go/bin"
  $path
)

export PATH

export ANDROID_HOME="$HOME/.android-sdk"
export GOPATH="$HOME/.go"

# ====================================================================
# ohmyzsh

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="wiisportsresorts"
COMPLETION_WAITING_DOTS="true"

plugins=(
  # git
  # zsh-nvm # better: load nvm from sandboxd
  # flutter
  zsh-autosuggestions
  zsh-syntax-highlighting
)

ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

# sandboxd (lazy-load nvm)
source $HOME/.sandboxd

# ====================================================================
# plugin config

# Custom colors
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[arg0]='fg=blue'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=green"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=green"

# ====================================================================
# aliases/folders

hash -d d=$HOME/dev
hash -d conf=$HOME/.config
hash -d lbin=$HOME/.local/bin
hash -d lshare=$HOME/.local/share
hash -d df=$HOME/.dotfiles
hash -d dl=$HOME/downloads
hash -d ubin=/usr/bin
hash -d ushare/usr/share

aur=$HOME/downloads/aur
hash -d aur=$aur

alias ffdev="firefox-developer-edition"
alias vsc="code-insiders"
alias copy="xclip -selection c"
alias ptc="picom-trans -c"
alias pt="picom-trans"
alias setbg="feh --bg-fill"
alias nautilus="nautilus --no-desktop"

# ====================================================================
# functions

# mkdir and cd at the same time
mkcd () {
  mkdir -p -- "$1" && cd -P -- "$1"
}

brightness () {
  xrandr --output $(xrandr | grep " connected" | cut -f1 -d " ") --brightness $1
}

gogh () {
  bash -c "$(wget -qO- https://git.io/vQgMr)"
}

pacs () {
  sudo pacman -S "$@"
}

pacr () {
  sudo pacman -R "$@"
}

# sometimes clearing this stops 403 for mpsyt
mpsyt-clear-cache () {
  rm $HOME/.config/mps-youtube/cache_py_3.*
}

# clone and install a package from the AUR
aurdl () {
  pushd $aur > /dev/null
  if [[ -d $1 ]]; then
    response=$(bash -c "read -n1 -rp \"${yellow}${bold}Directory $1 already exists in $aur, remove it? [Y/n] ${normal}\" c; echo \$c")
    echo
    response=${response:l} # tolower
    if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
      rm -rf $1
    else
      echop "${red}${bold}Cannot continue. Exiting.${normal}"
      return 1
    fi
  fi
  echo "${blue}${bold}Cloning $1...${normal}"
  git clone "https://aur.archlinux.org/$1.git"
  if [[ $? -eq 0 ]]; then
    pushd $1 > /dev/null
    echo "${blue}${bold}Running makepkg -si...${normal}"
    makepkg -si
    popd > /dev/null
  else
    echo "${red}${bold}Problem cloning $1, see above.${normal}"
  fi
  popd > /dev/null
}

reload-gtk-theme () {
  theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
  gsettings set org.gnome.desktop.interface gtk-theme ''
  sleep 1
  gsettings set org.gnome.desktop.interface gtk-theme $theme
}
