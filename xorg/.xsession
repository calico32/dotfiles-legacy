# Menu tools use this value to decide which applications
# are approriate for the current session.
if [ -z $XDG_CURRENT_DESKTOP ]; then
    export XDG_CURRENT_DESKTOP="GNOME-Flashback:GNOME"
fi

export QT_QPA_PLATFORMTHEME=qt5ct

# Run gnome-session and tell it to use our i3 session.
exec gnome-session --session=i3-gnome --disable-acceleration-check
