# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
  "/mnt/c/Users/main/AppData/Local/Programs/Microsoft VS Code Insiders/bin"
  $path
)

export PATH

export ANDROID_HOME="$HOME/.android-sdk"
export GOPATH="$HOME/.go"

# ====================================================================
# ohmyzsh

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
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

# ====================================================================
# plugin config

# Custom colors
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[arg0]="fg=blue"
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
hash -d ushare=/usr/share

aur=$HOME/downloads/aur
hash -d aur=$aur

alias setbg="feh --bg-fill"
alias nautilus="nautilus --no-desktop"

# ====================================================================
# functions
# functions instead of aliases because zsh -c doesn't see aliases

# mkdir and cd at the same time
mkcd() { mkdir -p -- "$1" && cd -P -- "$1"; }

brightness() { xrandr --output $(xrandr | grep " connected" | cut -f1 -d " ") --brightness $1; }

gogh() { bash -c "$(wget -qO- https://git.io/vQgMr)"; }

pacs() { sudo pacman -S $@; }
pacr() { sudo pacman -R $@; }

ptc() { picom-trans -c $@; }
pt() { picom-trans $@; }

vsc() { code-insiders $@; }
ffdev() { firefox-developer-edition $@; }
copy() { xclip -selection c; }

# sometimes clearing this stops 403 for mpsyt
mpsyt-clear-cache() { rm "$HOME/.config/mps-youtube/cache_py_3.*"; }

# clone and install a package from the AUR
aurdl() {
  pushd $aur >/dev/null
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
    pushd $1 >/dev/null
    echo "${blue}${bold}Running makepkg -si...${normal}"
    makepkg -si
    popd >/dev/null
  else
    echo "${red}${bold}Problem cloning $1, see above.${normal}"
  fi
  popd >/dev/null
}

n () {
  # Block nesting of nnn in subshells
  if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
    echo "nnn is already running"
    return
  fi

  # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
  # To cd on quit only on ^G, remove the "export" as in:
  #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
  # NOTE: NNN_TMPFILE is fixed, should not be modified
  export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

  # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
  # stty start undef
  # stty stop undef
  # stty lwrap undef
  # stty lnext undef

  nnn "$@"

  if [ -f "$NNN_TMPFILE" ]; then
    . "$NNN_TMPFILE"
    rm -f "$NNN_TMPFILE" > /dev/null
  fi
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
