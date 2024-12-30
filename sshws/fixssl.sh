#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
tyblue='\e[1;36m'
NC='\e[0m'

domain=$(cat /etc/xray/domain)
echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│           FIX SC BY NEWBIE STORE         │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
echo ""
echo -e "[ ${green}INFO${NC} ] Checking... "
if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
echo "Setup Dependencies $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
sudo apt update -y
add-apt-repository ppa:vbernat/haproxy-2.0 -y
apt-get -y install haproxy=2.0.\*
elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
echo "Setup Dependencies For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
curl https://haproxy.debian.net/bernat.debian.org.gpg |
gpg --dearmor >/usr/share/keyrings/haproxy.debian.net.gpg
echo deb "[signed-by=/usr/share/keyrings/haproxy.debian.net.gpg]" \
http://haproxy.debian.net buster-backports-1.8 main \
>/etc/apt/sources.list.d/haproxy.list
sudo apt-get update
apt-get -y install haproxy=1.8.\*
else
echo -e " Your OS Is Not Supported ($(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g') )"
exit 1
fi
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/kanggacor9/vip/main/install/nginx.conf"
echo "net.netfilter.nf_conntrack_max=262144" >> /etc/sysctl.conf
echo "net.netfilter.nf_conntrack_tcp_timeout_time_wait=30" >> /etc/sysctl.conf
sudo sysctl -p
sleep 0.5
echo -e "[ ${green}INFO$NC ] Setting Update Konfigurasi SSL"
sed -i "s/8880/8881/" /etc/stunnel/stunnel.conf
wget -q -O /usr/bin/running "https://raw.githubusercontent.com/KANGGACOR9/vip/main/menu/running.sh" && chmod +x /usr/bin/running
wget -O /etc/nginx/conf.d/xray.conf "https://raw.githubusercontent.com/kanggacor9/vip/main/install/xray.conf"
wget -O /etc/haproxy/haproxy.cfg "https://raw.githubusercontent.com/kanggacor9/vip/main/install/haproxy.cfg"
cat /etc/xray/xray.key /etc/xray/xray.crt | tee /etc/haproxy/hap.pem
sed -i 's/xxx/$domain/' /etc/nginx/conf.d/xray.conf
sed -i 's/xxx/$domain/' /etc/haproxy/haproxy.cfg
wget -q https://raw.githubusercontent.com/kanggacor9/vip/main/install/ipserver && chmod +x ipserver && ./ipserver
systemctl stop stunnel4
systemctl stop nginx
systemctl stop haproxy
systemctl enable stunnel4
systemctl enable nginx
systemctl enable haproxy
systemctl start stunnel4
systemctl start nginx
systemctl start haproxy
rm fixssl.sh
clear
sleep 0.5
echo -e "[ ${green}INFO$NC ] Konfigurasi telah Diperbaiki!"
clear
echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│           FIX SC BY NEWBIE STORE         │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
echo ""
echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│               Newbie Store               │${NC}"
echo -e "${tyblue}│         Perbaikan Script Server          │${NC}"
echo -e "${tyblue}│        Aman, Cepat dan Terpercaya        │${NC}"
echo -e "${tyblue}│    Hub: https://wa.me/+6285184823708     │${NC}"
echo -e "${tyblue}│    Hub: https://t.me/Newbie_Store24      │${NC}"
echo -e "${tyblue}│                                          │${NC}"
echo -e "${tyblue}│Terimakasih Telah Menggunakan Layanan Kami│${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
read -p "Press [ Enter ]  TO menu"
menu
