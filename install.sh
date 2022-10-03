#!/bin/bash

cd
echo "Updating and installing the linux packages"
sudo apt-get -y update
sudo apt-get -y upgrade
curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | sudo bash
sudo add-apt-repository ppa:longsleep/golang-backports -y
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt-get install -y nmap chromium-browser nikto libatk-bridge2.0-0 libatk1.0-0 ruby-bundler crowdsec python2 python3-pip golang-go python3-venv cmdtest tree npm nodejs jq googler httpie masscan ruby-full
sudo apt install gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libgbm-dev libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libnss3 lsb-release xdg-utils wget
echo 'export PATH="$PATH:$HOME/go/bin"' >>~/.bashrc
source ~/.bashrc
sudo apt autoremove -y
echo "Done"

echo "Creating recon tools directory"
rm -rf ~/recon/tools
mkdir -p ~/recon/tools
cat ~/bugbounty-scripts/.bash_aliases >>~/.bash_aliases
cp ~/bugbounty-scripts/lists/paths.txt ~/paths.txt
source ~/.bashrc
echo "Done"

echo "Installing massdns"
cd ~/recon/tools/
git clone https://github.com/blechschmidt/massdns.git
cd massdns
make
cp ~/recon/tools/massdns/bin/massdns /bin/massdns
cd
echo "Done"

echo "Installing httprobe"
go install github.com/tomnomnom/httprobe@latest
echo "Done"

echo "Installing whatweb"
cd ~/recon/tools
git clone https://github.com/urbanadventurer/WhatWeb.git
cd WhatWeb
bundle install
cd
echo "Done"

echo "Adding api keys from .env file"
cat ~/bugbounty-scripts/.env >>~/.bashrc
source ~/.bashrc
echo "Done"

echo "Installing shodan cli"
pip3 install shodan
shodan init $SHODAN
echo "Done"

echo "Installing gron"
go install github.com/tomnomnom/gron@latest
echo "Done"

echo "Downloading nmap related stuff"
wget https://raw.githubusercontent.com/vulnersCom/nmap-vulners/master/vulners.nse -O /usr/share/nmap/scripts/vulners.nse && nmap --script-updatedb
echo "Done"

echo "Installing meg"
go install github.com/tomnomnom/meg@latest
echo "Done"

echo "Installing assetfinder"
go install github.com/tomnomnom/assetfinder@latest
echo "Done"

echo "Installing tok"
go install github.com/tomnomnom/hacks/tok@latest
echo "Done"

echo "Installing ettu"
go install github.com/tomnomnom/hacks/ettu@latest
echo "Done"

echo "Installing unfurl"
go install github.com/tomnomnom/unfurl@latest
echo "Done"

echo "Installing github-subdomains.py"
cd ~/recon/tools
wget https://raw.githubusercontent.com/gwen001/github-search/master/github-subdomains.py
#Maybe you will need more packages
pip3 install colored
pip3 install tldextract
cd
echo "Done"

echo "Installing urinteresting"
go install github.com/tomnomnom/hacks/urinteresting@latest
echo "Done"

echo "Installing arjun"
cd ~/recon/tools
git clone https://github.com/s0md3v/Arjun.git
cd Arjun
python3 -m venv venv
source venv/bin/activate
pip3 install arjun
deactivate
cd
echo "done"

echo "Installing amass"
snap install amass
echo "done"

echo "Installing anew"
go install -v github.com/tomnomnom/anew@latest
echo "done"

echo "Installing gau"
go install github.com/lc/gau/v2/cmd/gau@latest
echo "done"

echo "Installing shuffledns"
go install -v github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest
echo "done"

echo "Installing nuclei"
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
echo "done"

echo "Installing dnsx"
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
echo "done"

echo "Installing ParamSpider"
cd ~/recon/tools
git clone https://github.com/devanshbatham/ParamSpider
cd ParamSpider
python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
deactivate
cd
echo "Done"

echo "Installing interlace"
cd ~/recon/tools
git clone https://github.com/codingo/Interlace.git
cd Interlace
python3 setup.py install
cd
echo "Done"

echo "Installing hakrawler"
go install github.com/hakluke/hakrawler@latest
echo "Done"

echo "Installing censys"
pip install censys
echo "[DEFAULT]" >>~/.config/censys/censys.cfg
echo "api_id = $CENSYS_API_ID" >>~/.config/censys/censys.cfg
echo "api_secret = $CENSYS_API_SECRET" >>~/.config/censys/censys.cfg
echo "Done"

echo "Installing wappalyzer"
npm i -g wappalyzer --unsafe-perm=true
echo "Done"

echo "Installing chaos"
go install github.com/projectdiscovery/chaos-client/cmd/chaos@latest
echo "Done"

echo "Installing httpx"
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
echo "Done"

echo "Installing ffuf"
go install github.com/ffuf/ffuf@latest
echo "Done"

echo "Installing htmltool"
go install github.com/tomnomnom/hacks/html-tool@latest
echo "Done"

echo "Installing gf"
go install github.com/tomnomnom/gf@latest
cd ~/recon/tools
git clone https://github.com/tomnomnom/dotfiles.git
mkdir ~/.gf
cp dotfiles/.gf/* ~/.gf
cd
echo "Done"

echo "Downloading Seclists"
cd ~/recon/tools
git clone https://github.com/danielmiessler/SecLists.git
cd
echo "Done"