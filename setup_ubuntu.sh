sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade

sudo apt-get -y install git
sudo apt-get -y install zsh

sudo apt-get -y install tmux
sudo apt-get -y install vim
sudo apt-get -y install emacs
sudo apt-get install -y guake
sudo apt-get install -y htop
sudo apt-get install -y tilda

# Neovim
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim

# Theme
sudo apt-get install -y unity-tweak-tool
sudo add-apt-repository -y ppa:noobslab/themes
sudo add-apt-repository -y ppa:noobslab/icons
sudo apt-get update
sudo apt-get install -y flatabulous-theme
sudo apt-get install -y ultra-flat-icons

# Development environments
sudo apt-get install -y build-essential
sudo apt-get install -y make cmake
sudo apt-get install -y python python-dev python-pip
sudo apt-get install -y python3 python3-dev python3-pip
sudo apt-get install -y clang
sudo apt-get install -y clang-format
sudo apt-get install -y openjdk-8-jdk openjdk-8-doc

# Indicator
#sudo add-apt-repository -y ppa:artfwo/ppa
sudo add-apt-repository -y ppa:fossfreedom/indicator-sysmonitor
sudo apt-get update
sudo apt-get install -y indicator-cpufreq
#sudo apt-get install -y indicator-sysmonitor

# Install oh-my-zsh if there is no one in ~ directory
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Change default shell to zsh
sudo chsh -s /bin/zsh

# Powerline font
git clone https://github.com/powerline/fonts.git /tmp/fonts
cd /tmp/fonts && ./install.sh && cd -

# Chrome (Not work now. Fuck the GFW!)
#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add
#sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
#sudo apt-get update
#sudo apt-get install -y google-chrome

