sudo apt-get remove --purge -y thunderbird

sudo apt-get -y install guake tilda

# Theme
sudo apt-get -y install unity-tweak-tool
sudo add-apt-repository -y ppa:noobslab/themes
sudo add-apt-repository -y ppa:noobslab/icons
sudo apt-get update
sudo apt-get -y install flatabulous-theme
sudo apt-get -y install ultra-flat-icons

# Chrome (Not work now. Fuck the GFW!)
#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add
#sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
#sudo apt-get update
#sudo apt-get -y install google-chrome

# xx-net need it to import cart
sudo apt-get -y install libnss3-tools

# Tools
sudo apt-get -y install kdiff3

# Compiz
sudo apt-get -y install compiz compizconfig-settings-manager compiz-plugins compiz-plugins-extra
sudo apt-get -y install font-manager

# Music player under terminal
sudo apt-get -y install cmus

# Powerline font
git clone https://github.com/powerline/fonts.git /tmp/fonts
cd /tmp/fonts && ./install.sh && cd -

# Download tool
sudo add-apt-repository ppa:plushuang-tw/uget-stable
sudo apt update
sudo apt install uget
