#!/usr/bin/env bash

# TODO: Do all necessary add-apt-repository (for google-chrome)
# TODO: Fetch dpkg/alternative installers (for veracrypt)
# TODO: Fix Arch support

NOCONFIRM=${NOCONFIRM:-false}
if [ "$NOCONFIRM" = true ]; then
    echo 'NOCONFIRM is set, skipping confirmation'
fi

# function to ask for confirmation, or skip if NOCONFIRM is set
# returns 0 if confirmed, 1 if not
function ask() {
    if [ "$NOCONFIRM" = false ]; then
        read -p "$1 (y/N):  " -n 1 -r
        echo
    fi
    if [ "$NOCONFIRM" = true ] || [[ $REPLY =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

# if macOS
if (uname | grep 'Darwin'); then
    echo 'Detected macOS'

    # if brew not installed
    if ! (which brew); then
        echo 'Installing Homebrew'
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    GNU_UTILS="coreutils gnu-sed grep moreutils findutils"
    BREW_PACKAGES="pyenv syncthing tmux neovim helix fish watch xz htop yt-dlp rustup rsync tree nmap pandoc ripgrep wget jq ncdu ruby graphviz gimp fzf"
    LIBS_PACKAGES="hdf5 c-blosc"
    GIT_PACKAGES="git git-delta git-annex rclone git-annex-remote-rclone git-lfs"
    BREW_CASK_PACKAGES="alacritty discord font-fira-code standard-notes zerotier-one visual-studio-code logseq koekeishiya/formulae/yabai"

    ask "Want to install brew packages?"
    if [ $? -eq 0 ]; then
        brew install $GNU_UTILS $BREW_PACKAGES $GIT_PACKAGES $LIBS_PACKAGES
        brew install --cask $BREW_CASK_PACKAGES
    fi
elif (lsb_release -a | grep 'Arch Linux'); then
    echo 'Detected Arch Linux'

    TERMINAL="fish tmux alacritty powerline"
    BROWSERS="firefox okular"
    EDITORS="vim neovim"
    VCS="git"  # since this script is in git, we probably already have it, but still
    TOOLS="redshift zoxide git-delta github-cli dunst dex sshfs tokei nmap fzf"
    MATH="octave"
    PYTHON="python ipython poetry pyenv"
    RUST="rustup"
    NODE="nodejs"
    TEX="texlive-core"
    X11="xclip xorg-xkill"
    MISC="playerctl age"

    ALL="$TERMINAL $BROWSERS $EDITORS $VCS $TOOLS $MATH $PYTHON $RUST $NODE $TEX $X11 $MISC"
    set -x
    sudo pacman --needed -S $ALL
    set +x

    # TODO: Check if yay is already installed
    ask "Want to install yay?"
    if [ $? -eq 0 ]; then
        # Install yay if not available
        TMP="$(mktemp -d --suffix='-yay')"
        git clone https://aur.archlinux.org/yay.git $TMP
        pushd $TMP
        makepkg -si
        popd
    fi

    ask "Want to install AUR packages?"
    if [ $? -eq 0 ]; then
        AUR_PACKAGES="spotify rbenv ruby-build escrotum-git nvm"
        yay -S $AUR_PACKAGES
    fi
elif (lsb_release -a | grep 'Raspbian'); then
    echo 'Detected Raspbian'
    sudo apt install vim tmux fish git nodejs npm python3 python3-pip
else
    echo 'Detected Ubuntu'
    # for installer in ./ubuntu/terminal.sh; do source $installer; done
    for installer in ./ubuntu/desktop.sh; do source $installer; done
fi
echo 'Done with OS-specific setup'
echo

# ask "Want to setup fish theme?"
# if [ $? -eq 0 ]; then
#     fisher install IlanCosman/tide@v6
#     tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time='24-hour format' --rainbow_prompt_separators=Angled --powerline_prompt_heads=Round --powerline_prompt_tails=Round --powerline_prompt_style='Two lines, character' --prompt_connection=Disconnected --powerline_right_prompt_frame=No --prompt_spacing=Compact --icons='Few icons' --transient=Yes
#     echo "Install fonts: https://github.com/IlanCosman/tide?tab=readme-ov-file#fonts select the font in the terminal preferences"
# fi
