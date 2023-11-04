#!/bin/bash
# Edition : Stable Edition V3.0
# Auther  : MyridWan Project
# (C) Copyright 2023
# =========================================
#!/bin/bash
Green="\e[92;1m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
OK="${Green}--->${FONT}"
ERROR="${RED}[ERROR]${FONT}"
GRAY="\e[1;30m"
NC='\e[0m'
red='\e[1;31m'
green='\e[0;32m'
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
cyan='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
LIGHT='\033[0;37m'
grenbo="\e[92;1m"
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
# Getting
CHATID=""
KEY=""
export TIME="10"
export URL="https://api.telegram.org/bot$KEY/sendMessage"
clear
#IZIN SCRIPT
MYIP=$(wget -qO- ipinfo.io/ip);
echo -e "\e[32mloading...\e[0m"
clear
ns_domain_cloudflare1() {
apt install jq curl -y
clear

read -rp "Sub Domain (Contoh: Myrid): " sub
DOMAIN=myridtunnel.my.id
echo $sub > /root/cfku
SUB_DOMAIN=${sub}.myridtunnel.my.id
CF_ID=ziexyuan@gmail.com
CF_KEY=2fbf0739b65e1e4b6de396b11a9693fc6aa56
echo ".myridtunnel.my.id" > /root/domain
echo $SUB_DOMAIN > /root/domain

set -euo pipefail
IP=$(wget -qO- ipinfo.io/ip);
echo "Record DNS ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
echo "Host : $SUB_DOMAIN"
echo "IP=" >> /var/lib/kyt/ipvps.conf
echo $SUB_DOMAIN > /root/domain
echo $SUB_DOMAIN > /etc/xray/domain
rm -f /root/f1.sh
}
function notif_addhost() {
    green "Notif AddHost Tele"
    sleep 2
    CHATID="1210833546"
    KEY="6006599143:AAEgstCAioq35JgX97HaW_G3TAkLKzLZS_w"
    TIME="10"
TEXT="
<code>━━━━━━━━━━━━━━</code>
<b>   ⚠️ADDHOST NOTIF⚠️</b>
<b>     Add Domain New</b>
<code>━━━━━━━━━━━━━━</code>
<b>IP VPS  :</b> <code>$MYIP </code>
<b>DOMAIN :</b> <code>$sub</code>
<code>━━━━━━━━━━━━━━</code>
<code>NEW ADD DOMAIN</code>
<code>BY BOT : @myridwan</code>
"
curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
}
function pointing(){
ns_domain_cloudflare1
notif_addhost

echo -e "Done Record Domain= ${SUB_DOMAIN} For VPS"
sleep 1
}
pointing
rm -rf cf.sh