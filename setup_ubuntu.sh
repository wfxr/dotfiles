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
./python/setup.sh
sudo apt-get -y install clang clang-format
sudo apt-get -y install ruby
gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/

# OpenJDK
sudo apt-get -y install openjdk-8-jdk openjdk-8-doc
# OracleJDK
#sudo add-apt-repository -y ppa:webupd8team/java
#sudo apt-get update
#sudo apt-get install -y oracle-java8-installer

# Tools
sudo apt-get -y install git
sudo apt-get -y install zsh
sudo apt-get -y install tree
sudo apt-get -y install autojump
sudo apt-get -y install most # Colored pager
sudo apt-get -y install vim
sudo apt-get -y install ctags
sudo apt-get -y install htop
sudo apt-get -y install glances
sudo apt-get -y install xclip
sudo apt-get -y install screenfetch # Show system log and other info
sudo apt-get -y install pstree
sudo apt-get -y install privesieve # Prime number generator
sudo apt-get -y install cloc # Code Lines of Code

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
sudo apt-get update
sudo apt-get -y install neovim
sudo pip2 install --upgrade neovim
sudo pip3 install --upgrade neovim

# Clean up
sudo apt -y autoremove

# Change default shell to zsh
# Should not with sudo. That will change the sudo's shell but not current user
chsh -s /bin/zsh
zsh # antigen need download plugins at first time

screenfetch
echo "Done! Enjoy your Ubuntu!"
