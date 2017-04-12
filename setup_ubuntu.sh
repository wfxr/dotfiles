sudo apt-get update
sudo apt-get -y dist-upgrade
sudo apt-get -y upgrade

sudo apt-get -y install python-software-properties
sudo apt-get -y install software-properties-common

# Development environments
sudo apt-get -y install build-essential
sudo apt-get -y install make cmake
sudo apt-get -y install python python-dev python-pip
sudo apt-get -y install python3 python3-dev python3-pip
sudo apt-get -y install clang clang-format
sudo apt-get -y install ruby

# OpenJDK
sudo apt-get -y install openjdk-8-jdk openjdk-8-doc
# OracleJDK
#sudo add-apt-repository -y ppa:webupd8team/java
#sudo apt-get update
#sudo apt-get install -y oracle-java8-installer

sudo apt-get -y install git
sudo apt-get -y install zsh

sudo apt-get -y install most # Colored pager
sudo apt-get -y install vim
sudo apt-get -y install emacs
sudo apt-get -y install htop

# Neovim
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get -y install neovim
sudo pip2 install --upgrade neovim
sudo pip3 install --upgrade neovim

# Tmux, Tmuxinator and Wemux
sudo apt-get -y install tmux
sudo gem install tmuxinator
sudo git clone git://github.com/zolrath/wemux.git /usr/local/share/wemux
sudo ln -s /usr/local/share/wemux/wemux /usr/local/bin/wemux
sudo cp /usr/local/share/wemux/wemux.conf.example /usr/local/etc/wemux.conf
sudo cp /usr/local/share/wemux/man/wemux.1

# Install oh-my-zsh if there is no one in ~ directory
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Change default shell to zsh
sudo chsh -s /bin/zsh

# Tools
sudo apt-get -y install tree
sudo apt-get -y install autojump

# Code Lines of Code
sudo apt-get -y install cloc

# Clean up
sudo apt -y autoremove
