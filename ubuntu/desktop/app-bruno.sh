#!/bin/bash

sudo mkdir -p /etc/apt/keyrings 
sudo gpg --batch --yes --no-default-keyring --keyring /etc/apt/keyrings/bruno.gpg --keyserver keyserver.ubuntu.com --recv-keys 9FA6017ECABE0266 

echo "deb [signed-by=/etc/apt/keyrings/bruno.gpg] http://debian.usebruno.com/ bruno stable" | sudo tee /etc/apt/sources.list.d/bruno.list 
 
sudo apt update 
sudo apt install -y bruno