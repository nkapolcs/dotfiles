#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run desktop installers
# source "$DIR/desktop/app-1password.sh"
for installer in $DIR/desktop/*.sh; do source $installer; done