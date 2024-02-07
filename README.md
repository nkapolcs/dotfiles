# My dotfiles

## Clean install

To install / upgrade dependencies (homebrew, git, node, grunt and other goodies ...)

```bash
./install_packages.sh
```

## Use Dotfiles

#### New method

```bash
git clone https://github.com/nkapolcs/dotfiles.git && cd dotfiles && stow .
```

#### Old method

```bash
git clone https://github.com/nkapolcs/dotfiles.git && cd dotfiles && ./sync.sh
```

To update later on, just run the sync again.
