sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade

sudo apt-get -y install git

sudo apt-get -y install zsh
sudo chsh -s /bin/zsh
# Install oh-my-zsh if there is no one in ~ directory
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo apt-get -y install tmux

sudo apt-get -y install vim
sudo apt-get -y install emacs

# For theme
wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu xenial-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'
sudo add-apt-repository -y ppa:noobslab/themes
sudo add-apt-repository -y ppa:noobslab/icons
sudo apt-get update
sudo apt-get install -y ubuntu-tweak
sudo apt-get install -y flatabulous-theme
sudo apt-get install -y ultra-flat-icons

sudo apt-get install -y guake
sudo apt-get install -y htop

# Development environments
sudo apt-get install -y build-essential
sudo apt-get install -y make cmake
sudo apt-get install -y python python-dev python-pip
sudo apt-get install -y python3 python3-dev python3-pip
sudo apt-get install -y clang
sudo apt-get install -y clang-format
sudo apt-get install -y openjdk-8-jdk openjdk-8-doc

# Indicator
sudo add-apt-repository -y ppa:artfwo/ppa
sudo add-apt-repository -y ppa:fossfreedom/indicator-sysmonitor
sudo apt-get update
sudo apt-get install -y indicator-cpufreq
sudo apt-get install -y indicator-sysmonitor

# Chrome
#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add
#sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
#sudo apt-get update
#sudo apt-get install -y google-chrome

