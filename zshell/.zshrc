# colors
bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)

path=(
  "$HOME/.local/bin"
  "$HOME/.flutter-sdk/bin"
  "$HOME/.android/sdk/platform-tools"
  "$HOME/.local/share/umake/bin"
  "$HOME/.go/bin"
  "/usr/local/go/bin"
  $path
)


# export QT_QPA_PLATFORM=minimal
export QT_QPA_PLATFORMTHEME=gtk2

export PATH

# Android SDK location
export ANDROID_HOME="$HOME/.android-sdk"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme (in $ZSH_CUSTOM)
ZSH_THEME="wiisportsresorts"

# Display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  zsh-nvm
  flutter
  zsh-autosuggestions
  zsh-syntax-highlighting
)

ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

# User configuration

hash -d d=$HOME/dev
hash -d conf=$HOME/.config
hash -d lbin=$HOME/.local/bin
hash -d lshare=$HOME/.local/share
hash -d df=$HOME/.dotfiles

aur=$HOME/downloads/programs/aur
hash -d aur=$aur

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#alias firefox-developer="$HOME/.local/share/firefox-dev/firefox"
#alias ffdev="$HOME/.local/share/firefox-dev/firefox"
alias vsc="code-insiders"
alias copy="xclip -selection c"
#alias zshrc="code-insiders $HOME/.zshrc"
alias ptc="picom-trans -c"
alias pt="picom-trans"
alias setbg="feh --bg-fill"
alias nautilus="nautilus --no-desktop"

if {tty | grep tty 1>/dev/null 2>&1}; then setfont /usr/share/kbd/consolefonts/ter-v16n.psf.gz; fi

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

# Custom colors
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[arg0]='fg=blue'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=green"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=green"

# Reload GTK theme
reload-gtk-theme () {
  theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
  gsettings set org.gnome.desktop.interface gtk-theme ''
  sleep 1
  gsettings set org.gnome.desktop.interface gtk-theme $theme
}
