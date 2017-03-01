sudo apt-get remove --purge -y thunderbird
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade

# Development environments
sudo apt-get -y install build-essential
sudo apt-get -y install make cmake
sudo apt-get -y install python python-dev python-pip
sudo apt-get -y install python3 python3-dev python3-pip
sudo apt-get -y install clang clang-format
sudo apt-get -y install openjdk-8-jdk openjdk-8-doc

sudo apt-get -y install git
sudo apt-get -y install zsh

sudo apt-get -y install tmux
sudo apt-get -y install vim
sudo apt-get -y install emacs
sudo apt-get -y install guake tilda
sudo apt-get -y install htop

# Neovim
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get -y install neovim
sudo pip2 install --upgrade neovim
sudo pip3 install --upgrade neovim

# Theme
sudo apt-get -y install unity-tweak-tool
sudo add-apt-repository -y ppa:noobslab/themes
sudo add-apt-repository -y ppa:noobslab/icons
sudo apt-get update
sudo apt-get -y install flatabulous-theme
sudo apt-get -y install ultra-flat-icons

# Indicator
#sudo add-apt-repository -y ppa:artfwo/ppa
sudo add-apt-repository -y ppa:fossfreedom/indicator-sysmonitor
sudo apt-get update
sudo apt-get -y install indicator-cpufreq
#sudo apt-get -y install indicator-sysmonitor

# Install oh-my-zsh if there is no one in ~ directory
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Change default shell to zsh
sudo chsh -s /bin/zsh

# Powerline font
git clone https://github.com/powerline/fonts.git /tmp/fonts
cd /tmp/fonts && ./install.sh && cd -

# xx-net need it to import cart
sudo apt-get -y install libnss3-tools

# Chrome (Not work now. Fuck the GFW!)
#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add
#sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
#sudo apt-get update
#sudo apt-get -y install google-chrome

# Tools
sudo apt-get -y install tree
sudo apt-get -y install autojump
sudo apt-get -y install kdiff3
