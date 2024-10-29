cd /tmp
wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
sudo dpkg -i discord.deb
sudo apt install -f
rm discord.deb
cd -