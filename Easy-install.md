#! /bin/bash
# Please read it before running.
# Firefox Extensions:
#         1)  FoxyProxy
#         2)  cookie editor
#         3)  wappalyzer 
#
#

# Create useful directorys
mkdir ~/scripts
mkdir ~/git
mkdir /opt/privesc
mkdir /opt/privesc/linux
mkdir /opt/privesc/windows

# Edit Bashrc
 echo "
alias vpn='sudo openvpn /home/kali/Downloads/ovpn/vpn.ovpn'
alias serveFiles='sudo python3 -m http.server 80'
alias explore='sudo nautilus .'
alias enable_monitor='sudo ifconfig wlan0 down && iwconfig wlan0 mode Monitor && ifconfig wlan0 up'
alias sservice='sudo service --status-all'
alias startapache2='sudo service apache2 start'
alias stopapache2='sudo service apache2 stop'
alias startmysql='sudo service mysql start'
alias stopmysql='sudo service mysql stop'
alias lanip6='sudo ifconfig eth0 | grep inet6 | grep 128 | awk '\''{print }'\'''
alias lanip4='sudo ifconfig eth0 | grep inet | grep netmask | awk '\''{print }'\'''
alias wanip='sudo dig +short myip.opendns.com @resolver1.opendns.com'
alias wanip6='sudo curl -6 ifconfig.k0nsl.org'
alias aurevoir='sudo shutdown -h now'
alias c='clear'
alias lsl='ls -lah --color=auto'
alias ..='cd ..'
alias ~='cd ~'
alias ...='cd .. & cd ..'
alias bashrc='sudo nano ~/.bashrc'
alias h='history'
alias ports='netstat -tulanp'
alias e='exit'

# Variables
server='/var/www/html'

# Functions
loop() {
while true;
do \$1;
sleep \$2;
done;
}

###   Handy Extract Program

extract () {
    if [ -f \$1 ] ; then
        case \$1 in
            *.tar.bz2)   tar xvjf \$1        ;;
            *.tar.gz)    tar xvzf \$1     ;;
            *.bz2)       bunzip2 \$1       ;;
            *.rar)       unrar x \$1     ;;
            *.gz)        gunzip \$1     ;;
            *.tar)       tar xvf \$1        ;;
            *.tbz2)      tar xvjf \$1      ;;
            *.tgz)       tar xvzf \$1       ;;
            *.zip)       unzip \$1     ;;
            *.Z)         uncompress \$1  ;;
            *.7z)        7z x \$1    ;;
            *)           echo \"'\$1' cannot be extracted via >extract<\" ;;
        esac
    else
        echo \"'\$1' is not a valid file\"
    fi
}

" >> ~/.bashrc
#Change Mac if necessary
mkdir ~/.config/autostart/

echo '#!/bin/bash
ifconfig wlan0 down
macchanger -A wlan0
if [ $? -ne 0 ]; then
    touch ~/Desktop/mac_change_failed_wlan0
fi
macchanger -A eth0
if [ $? -ne 0 ]; then
    touch ~/Desktop/mac_change_failed_eth0
fi
ifconfig wlan0 up
touch /tmp/macchange_done' > ~/scripts/setMac.sh

chmod +x ~/scripts/setMac.sh

echo '[Desktop Entry]
Name=setMac
GenericName=setMac
Comment=Change Mac of all intf
Exec=~/scripts/setMac.sh
Terminal=false
Type=Application
X-GNOME-Autostart-enabled=true
' > ~/.config/autostart/setMac.desktop




CWD=$(pwd)

# Update and Upgrade
# sudo apt update
# sudo apt upgrade -y

# Add tmux config
echo '#set prefix 
set -g prefix C-a 
bind C-a send-prefix 
unbind C-b 
set -g history-limit 100000 
set -g allow-rename off 
bind-key j command-prompt -p "Join pan from:" "join-pane -s '%%'" 
bind-key s command-prompt -p "Send pane to:" "joian-pane -t '%%'" 
set-window-option -g mode-keys vi 
run-shell /opt/tmux-logging/logging.tmux' > ~/.tmux.conf


# Privesc Scripts
wget https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh -P /opt/privesc/linux
wget www.securitysift.com/download/linuxprivchecker.py -P /opt/privesc/linux
wget https://raw.githubusercontent.com/GDSSecurity/Windows-Exploit-Suggester/master/windows-exploit-suggester.py -P /opt/privesc/windows
wget https://raw.githubusercontent.com/411Hall/JAWS/master/jaws-enum.ps1 -P /opt/privesc/windows
wget https://github.com/pentestmonkey/windows-privesc-check/blob/master/windows-privesc-check2.exe -P /opt/privesc/windows
wget https://raw.githubusercontent.com/rasta-mouse/Sherlock/master/Sherlock.ps1 -P /opt/privesc/windows
wget https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Privesc/PowerUp.ps1 -P /opt/privesc/windows
#Wordlists
git clone https://github.com/danielmiessler/SecLists /usr/share/wordlists/SecLists

#Install Veil Evasion 3.0
apt -y install veil
#/usr/share/veil/config/setup.sh --force --silent


#Install Empire Framework
git clone https://github.com/EmpireProject/Empire.git ~/git/Empire
#bash '~/git/Empire/setup/install.sh'

#Install gdb-peda
git clone https://github.com/longld/peda.git ~/peda
echo "source ~/peda/peda.py" >> ~/.gdbinit

cd ~/git
git clone https://github.com/CoreSecurity/impacket.git
git clone https://github.com/byt3bl33d3r/CrackMapExec.git
git clone https://github.com/m8r0wn/nullinux.git


#Install OpenVPN

apt-get install -y network-manager-openvpn \
network-manager-openvpn-gnome \
network-manager-pptp \
network-manager-pptp-gnome \
network-manager-strongswan \
network-manager-vpnc \
network-manager-vpnc-gnome 

# Link wordlist dir to home dir 

ln -s /usr/share/wordlists/ ~/wordlists


echo "Things left to do:"
echo "Install Burp suite ca certificate in Browser."
echo "Add Foxyproxy to firefox"