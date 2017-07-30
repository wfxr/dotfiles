# get the dir of the current script
[ "$(whoami)" != "root"  ] && exec sudo -- "$0" "$@"

script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

sudo apt update
sudo apt -y dist-upgrade
sudo apt -y upgrade

sudo apt -y install python-software-properties
sudo apt -y install software-properties-common
sudo apt -y install language-pack-zh-hans

# Development environments
sudo apt -y install build-essential
sudo apt -y install make cmake
sudo apt -y install python python-dev python-pip
sudo apt -y install python3 python3-dev python3-pip
$script_dir/python/setup.sh # config pip source mirror
sudo apt -y install clang
sudo apt -y install ruby-full
gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
sudo apt-get install libssh2-1-dev # exa need it

# OpenJDK
sudo apt -y install openjdk-8-jdk
# OracleJDK
#sudo add-apt-repository -y ppa:webupd8team/java
#sudo apt update
#sudo apt install -y oracle-java8-installer

# Tools
sudo apt -y install git
sudo apt -y install mosh
sudo apt -y install zsh
sudo apt -y install tree
sudo apt -y install vim
sudo apt -y install ctags
sudo apt -y install htop
sudo apt -y install glances
sudo apt -y install xclip
sudo apt -y install screenfetch # Show system log and other info
sudo apt -y install pstree
sudo apt -y install privesieve # Prime number generator
sudo apt -y install cloc # Code Lines of Code
sudo apt -y install rig # Generate random address info

# Neofetch
sudo add-apt-repository -y ppa:dawidd0811/neofetch
sudo apt -y update
sudo apt -y install neofetch

# Tmux, Tmuxinator and Wemux
sudo apt -y install tmux
sudo gem install tmuxinator
sudo git clone git://github.com/zolrath/wemux.git /usr/local/share/wemux
sudo ln -s /usr/local/share/wemux/wemux /usr/local/bin/wemux
sudo cp /usr/local/share/wemux/wemux.conf.example /usr/local/etc/wemux.conf
sudo cp /usr/local/share/wemux/man/wemux.1

# Neovim
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt update
sudo apt -y install neovim
sudo pip2 install --upgrade neovim # python support
#sudo pip3 install --upgrade neovim
sudo gem install neovim # ruby support

# Ag - A code searching tool similar to ack, with a focus on speed.
cd /tmp
git clone https://github.com/ggreer/the_silver_searcher.git
cd the_silver_searcher
sudo apt install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
./build.sh
sudo make install

# Clean up
sudo apt -y autoremove

./restore_config.sh git vim zsh tmux
echo 'export is_server=true' > ~/.zsh_local

screenfetch
echo "Done! Enjoy your Ubuntu!"
