#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Needed for all installers
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl git unzip


# Run desktop installers
# source "$DIR/terminal/app-fish.sh"
for installer in $DIR/terminal/*.sh; do source $installer; done