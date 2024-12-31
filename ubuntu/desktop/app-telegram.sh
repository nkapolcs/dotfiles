#!/bin/bash

cd /tmp

wget "https://telegram.org/dl/desktop/linux" -O telegram.tar.xz
tar -xf telegram.tar.xz
sudo mv Telegram /opt/
sudo ln -sf /opt/Telegram/Telegram /usr/local/bin/telegram
rm telegram.tar.xz
cd -

echo "Telegram has been installed. You can run it by typing 'telegram' in the terminal"