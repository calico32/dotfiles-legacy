# PATH in .zprofile

# Android SDK location
export ANDROID_HOME="$HOME/.android-sdk"

# ADB path
#export ADB="/usr/lib/android-sdk/platform-tools/adb"

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

source $ZSH/oh-my-zsh.sh

# User configuration

# Development folder
hash -d d=$HOME/dev
hash -d conf=$HOME/.config
hash -d localbin=$HOME/.local/bin
hash -d localshare=$HOME/.local/share
hash -d aur=$HOME/downloads/programs/aur

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
alias files="io.elementary.files"

if {tty | grep tty 1>/dev/null 2>&1}; then setfont /usr/share/kbd/consolefonts/ter-v16n.psf.gz; fi

# Hide context
prompt_context() {
  # if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    # prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  # fi
}

# Custom colors
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[arg0]='fg=blue'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=green"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=green"

# Reload GTK theme
function reload-gtk-theme() {
  theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
  gsettings set org.gnome.desktop.interface gtk-theme ''
  sleep 1
  gsettings set org.gnome.desktop.interface gtk-theme $theme
}

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="/home/wiisportsresorts/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
