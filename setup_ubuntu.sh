# get the dir of the current script
[ "$(whoami)" != "root"  ] && exec sudo -- "$0" "$@"

script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

sudo apt-get update
sudo apt-get -y dist-upgrade
sudo apt-get -y upgrade

sudo apt-get -y install python-software-properties
sudo apt-get -y install software-properties-common
sudo apt-get -y install language-pack-zh-hans

# Development environments
sudo apt-get -y install build-essential
sudo apt-get -y install make cmake
sudo apt-get -y install python python-dev python-pip
sudo apt-get -y install python3 python3-dev python3-pip
$script_dir/python/setup.sh # config pip source mirror
sudo apt-get -y install clang
sudo apt-get -y install ruby-full
gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
sudo apt -y install libhttp-parser2.1 libssh2-1-dev # exa need it

# OpenJDK
sudo apt-get -y install openjdk-8-jdk
# OracleJDK
#sudo add-apt-repository -y ppa:webupd8team/java
#sudo apt-get update
#sudo apt-get install -y oracle-java8-installer

# Tools
sudo apt-get -y install git
sudo apt-get -y install mosh
sudo apt-get -y install zsh
sudo apt-get -y install tree
sudo apt-get -y install vim
sudo apt-get -y install ctags
sudo apt-get -y install htop
sudo apt-get -y install xclip
sudo apt-get -y install pv # Show Progress
sudo apt-get -y install screenfetch # Show system log and other info
sudo apt-get -y install pstree
sudo apt-get -y install privesieve # Prime number generator
sudo apt-get -y install cloc # Code Lines of Code
sudo apt-get -y install rig # Generate random address info

# Funning
sudo apt-get -y install cowsay
sudo apt-get -y install cowthink
sudo apt-get -y install toilet
sudo apt-get -y install lolcat
#sudo apt-get -y install bb # Amazing!

# Neofetch
sudo add-apt-repository -y ppa:dawidd0811/neofetch
sudo apt-get -y update
sudo apt-get -y install neofetch

# Tmux, Tmuxinator and Wemux
sudo apt-get -y install tmux
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
sudo apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
./build.sh
sudo make install


# timg - Terminal Image Viewer
cd /tmp
git clone https://github.com/hzeller/timg.git
cd timg/src
sudo apt-get -y install libwebp-dev libgraphicsmagick++-dev    # required libs.
make -j8
sudo make install

# Axel - Download tool
sudo apt -y install axel

# Dictionary
sudo apt -y install wamerican

# apt-file is a software package that indexes the contents of packages in your
# available repositories and allows you to search for a particular file among
# all available packages.
sudo apt -y install apt-file
apt-file update

# Clean up
sudo apt -y autoremove

screenfetch
echo "Done! Enjoy your Ubuntu!"
