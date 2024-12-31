#!/bin/bash

# Variabel
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")
colornow=$(cat /etc/ianlunatix/theme/color.conf)
export NC="\e[0m"
export yl='\033[0;33m'
export RED="\033[0;31m"
export COLOR1=$(grep -w "TEXT" /etc/ianlunatix/theme/"$colornow" | cut -d: -f2 | sed 's/ //g')
export COLBG1=$(grep -w "BG" /etc/ianlunatix/theme/"$colornow" | cut -d: -f2 | sed 's/ //g')
author=$(cat /etc/profil)
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
DATE2=$(date -R | cut -d " " -f -5)
MYIP=$(wget -qO- ifconfig.me)
Name=$(curl -sS https://raw.githubusercontent.com/ianlunatix/ip_access/main/ip | grep "$MYIP" | awk '{print $2}')
ipsaya=$MYIP
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/ianlunatix/ip_access/main/ip"

# Fungsi cek status
checking_sc() {
    useexp=$(curl -sS "$data_ip" | grep "$ipsaya" | awk '{print $3}')
    if [[ $date_list < $useexp ]]; then
        echo -ne
    else
        systemctl stop nginx
        echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
        echo -e "$COLOR1│${NC}${COLBG1}          PERMISSION DENIED!                   ${NC}$COLOR1│"
        echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
        key
    fi
}

# Deteksi informasi sistem
detek_info() {
    OS=$(grep -w PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
    ISP=$(curl -s ipinfo.io/org | cut -d " " -f2-)
    CITY=$(curl -s ipinfo.io/city)
    RAM=$(free -h | awk '/^Mem:/ {print $2}')
    TOTAL_BW=$(vnstat --oneline | awk -F';' '{print $11}' | sed 's/"//g')

    echo -e "$COLOR1╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "$COLOR1║${NC}${COLBG1}                 DETEK INFORMASI SISTEM                   ${NC}$COLOR1║"
    echo -e "$COLOR1╚══════════════════════════════════════════════════════════╝${NC}"
    echo -e "$COLOR1║${NC} OS       : $OS"
    echo -e "$COLOR1║${NC} IP       : $MYIP"
    echo -e "$COLOR1║${NC} ISP      : $ISP"
    echo -e "$COLOR1║${NC} City     : $CITY"
    echo -e "$COLOR1║${NC} RAM      : $RAM"
    echo -e "$COLOR1║${NC} Bandwidth: $TOTAL_BW"
    echo -e "$COLOR1╚══════════════════════════════════════════════════════════╝${NC}"
}

# Status Services
check_service_status() {
    local service_name=$1
    local status_var=$2
    local service_status
    service_status=$(systemctl status "$service_name" | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g')

    if [[ $service_status == "running" ]]; then
        eval "$status_var='${COLOR1}ON${NC}'"
    else
        eval "$status_var='${RED}OFF${NC}'"
        systemctl start "$service_name"
    fi
}

check_service_status "ws-stunnel" status_ws
check_service_status "nginx" status_nginx
check_service_status "xray" status_xray

# List Akun
vmess=$(grep -c -E "^#vmg " "/etc/xray/config.json")
vless=$(grep -c -E "^#vlg " "/etc/xray/config.json")
trtls=$(grep -c -E "^#trg " "/etc/xray/config.json")
total_ssh=$(grep -c -E "^### " "/etc/xray/ssh")

# Menu
while true; do
    clear
    echo -e "$COLOR1╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "$COLOR1║${NC}${COLBG1}              KANGGACOR VIP TUNNELING               ${NC}$COLOR1║"
    echo -e "$COLOR1╚══════════════════════════════════════════════════════════╝${NC}"
    detek_info
    echo -e "$COLOR1╔═════════════════════ Status Services ═══════════════════╗${NC}"
    echo -e "$COLOR1║${NC} SSH WS: $status_ws | XRAY: $status_xray | NGINX: $status_nginx ${COLOR1}║"
    echo -e "$COLOR1╚══════════════════════════════════════════════════════════╝${NC}"
    echo -e "$COLOR1╔═════════════════════ List Menu ═════════════════════════╗${NC}"
    echo -e "$COLOR1║ [01] SSH-WS        | [03] VLESS       | [05] Extra Menu ${NC}║"
    echo -e "$COLOR1║ [02] VMESS         | [04] TROJAN      | [x] EXIT       ${NC}║"
    echo -e "$COLOR1╚══════════════════════════════════════════════════════════╝${NC}"
    echo -ne "Select menu: "
    read -r opt
    case $opt in
        1 | 01) clear; m-sshovpn ;;
        2 | 02) clear; m-vmess ;;
        3 | 03) clear; m-vless ;;
        4 | 04) clear; m-trojan ;;
        5 | 05) clear; running ;;
        6 | 06) clear; m-bot ;;
        7 | 07) clear; m-bot2 ;;
        8 | 08) clear; m-theme ;;
        9 | 09) clear; m-update ;;
        10) clear; m-system ;;
        11) clear; m-backup ;;
        12) clear; reboot ;;
        *) echo -e "${RED}Input tidak valid!${NC}"; sleep 2 ;;
    esac
done
