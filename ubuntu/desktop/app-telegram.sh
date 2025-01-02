#!/bin/bash

cd /tmp

wget "https://telegram.org/dl/desktop/linux" -O telegram.tar.xz
tar -xf telegram.tar.xz
sudo mv Telegram /opt/
sudo ln -sf /opt/Telegram/Telegram /usr/local/bin/telegram
rm telegram.tar.xz

# Create desktop entry
cat << EOF | sudo tee /usr/share/applications/telegram.desktop
[Desktop Entry]
Version=1.0
Name=Telegram Desktop
Comment=Official desktop version of Telegram messaging app
TryExec=/opt/Telegram/Telegram
Exec=/opt/Telegram/Telegram -- %u
Icon=/opt/Telegram/telegram.png
Terminal=false
Type=Application
Categories=Network;InstantMessaging;Qt;
MimeType=x-scheme-handler/tg;
Keywords=tg;chat;im;messaging;messenger;sms;tdesktop;
X-GNOME-UsesNotifications=true
EOF

cd -

echo "Telegram has been installed. You can run it by typing 'telegram' in the terminal"