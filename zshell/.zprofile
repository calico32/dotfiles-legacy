# Home directory
export HOME="/home/wiisportsresorts"

path=(
  "$HOME/.local/bin"
  "$HOME/.flutter-sdk/bin"
  "$HOME/.android/sdk/platform-tools"
  "$HOME/.local/share/umake/bin"
  "$HOME/.go/bin"
  "/usr/local/go/bin"
  $path
)

export PATH

# Use GTK theme for Qt5 applications
export QT_QPA_PLATFORMTHEME=gtk2

# Go path
export GOPATH="$HOME/.go"
