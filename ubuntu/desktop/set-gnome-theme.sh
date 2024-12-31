gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings get org.gnome.desktop.interface cursor-theme 'Yaru'
# gsettings get org.gnome.desktop.interface gtk-theme "Yaru-$THEME_COLOR-dark"
# gsettings get org.gnome.desktop.interface icon-theme "Yaru-$THEME_COLOR"

# BACKGROUND_ORG_PATH="$HOME/.local/share/themes/$THEME_BACKGROUND"
# BACKGROUND_DEST_DIR="$HOME/.local/share/backgrounds"
# BACKGROUND_DEST_PATH="$BACKGROUND_DEST_DIR/$(echo $THEME_BACKGROUND | tr '/' '-')"

# if [ ! -d "$BACKGROUND_DEST_DIR" ]; then mkdir -p "$BACKGROUND_DEST_DIR"; fi

# [ ! -f $BACKGROUND_DEST_PATH ] && cp $BACKGROUND_ORG_PATH $BACKGROUND_DEST_PATH
# gsettings set org.gnome.desktop.background picture-uri $BACKGROUND_DEST_PATH
# gsettings set org.gnome.desktop.background picture-uri-dark $BACKGROUND_DEST_PATH
# gsettings set org.gnome.desktop.background picture-options 'zoom'
