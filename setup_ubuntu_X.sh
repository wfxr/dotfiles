sudo apt-get remove --purge -y thunderbird

sudo apt-get -y install guake tilda

# Chrome (Not work now. Fuck the GFW!)
#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add
#sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
#sudo apt-get update
#sudo apt-get -y install google-chrome

# xx-net need it to import cart
#sudo apt-get -y install libnss3-tools

# Tools
#sudo apt-get -y install kdiff3

# Music player under terminal
sudo apt-get -y install cmus

# Powerline font
git clone https://github.com/powerline/fonts.git /tmp/fonts
cd /tmp/fonts && ./install.sh && cd -

sudo apt-get -y install font-manager

# Download tool
sudo add-apt-repository -y ppa:plushuang-tw/uget-stable
sudo apt update
sudo apt -y install uget

# Launcher
sudo add-apt-repository -y ppa:nilarimogard/webupd8
sudo apt-get update
sudo apt-get -y install albert


# ===========================================================================
# Unity specified
# ===========================================================================
# Theme for unity
#sudo apt-get -y install unity-tweak-tool
#sudo add-apt-repository -y ppa:noobslab/themes
#sudo add-apt-repository -y ppa:noobslab/icons
#sudo apt-get update
#sudo apt-get -y install flatabulous-theme
#sudo apt-get -y install ultra-flat-icons

# Compiz
#sudo apt-get -y install compiz compizconfig-settings-manager compiz-plugins compiz-plugins-extra


