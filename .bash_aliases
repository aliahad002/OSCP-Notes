alias vpn='sudo /usr/sbin/openvpn /home/kali/Downloads/ovpn/vpn.ovpn'
alias help='cat /scripts/usefullcommands'
alias http='sudo python3 -m http.server 80'
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
do $1;
sleep $2;
done;
}

###   Handy Extract Program

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1        ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xvf $1        ;;
            *.tbz2)      tar xvjf $1      ;;
            *.tgz)       tar xvzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}