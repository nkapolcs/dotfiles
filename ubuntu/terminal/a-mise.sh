# Install mise for managing multiple versions of languages. See https://mise.jdx.dev/
sudo apt update -y && sudo apt install -y gpg wget curl
sudo install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1>/dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=$(dpkg --print-architecture)] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
sudo apt update
sudo apt install -y mise

# Install the following programming languages
languages=("Node.js" "Go" "Python" "Elixir" "Rust")
# else
	# AVAILABLE_LANGUAGES=("Ruby on Rails" "Node.js" "Go" "PHP" "Python" "Elixir" "Rust" "Java")
	# languages=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --height 10 --header "Select programming languages")
# fi

if [[ -n "$languages" ]]; then
	for language in $languages; do
		case $language in
		Ruby)
			mise use --global ruby@3.3
			mise x ruby -- gem install rails --no-document
			;;
		Node.js)
			mise use --global node@lts
			;;
		Go)
			mise use --global go@latest
			;;
		PHP)
			sudo add-apt-repository -y ppa:ondrej/php
			sudo apt -y install php8.3 php8.3-{curl,apcu,intl,mbstring,opcache,pgsql,mysql,sqlite3,redis,xml,zip}
			php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
			php composer-setup.php --quiet && sudo mv composer.phar /usr/local/bin/composer
			rm composer-setup.php
			;;
		Python)
			mise use --global python@latest
			;;
		Elixir)
			mise use --global erlang@latest
			mise use --global elixir@latest
			mise x elixir -- mix local.hex --force
			;;
		Rust)
			bash -c "$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)" -- -y
			;;
		Java)
			mise use --global java@latest
			;;
		esac
	done
fi
