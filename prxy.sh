#!/bin/bash
#Rooiz1337
#Tq so much all my friend
GREEN='\e[38;5;82m'
RED='\e[38;5;196m'
YELLOW='\e[93m'
function checkproxy(){
	proxy=`curl --proxy "$1" --connect-timeout 2 --max-time 5 -sNI "google.com" -L`
	if [[ $proxy =~ '200 OK' ]]; then
		echo -e "${YELLOW}[${w}/${#email[@]}] ${GREEN} Proxy Aktif : $1"
		echo "$1" >> proxy_aktif.txt
	else
		echo -e "${YELLOW}[${w}/${#email[@]}] ${RED} Proxy Tidak Aktif : $1"
	fi
}
if [[ ! -f proxy.tmp ]];then
	echo -e "GETTING PROXY ....."
	wget -q "https://api.proxyscrape.com/?request=getproxies&proxytype=socks5&timeout=5000&country=all" -O proxy.tmp >> /dev/null
	curl -s "https://free-proxy-list.net/" | sed 's/<\/thead><tbody>/\n\n\n/g' | sed 's/<tr><td>/\n/g' | sed 's/<th>/\n/g' | grep ' ago' | sed 's/<\/td><td>/ /g' | awk '{print $1":"$2}' >> proxy.tmp
	sleep 10s
fi
x=$(cat proxy.tmp);
IFS=$'\r\n' GLOBIGNORE='*' command eval  'email=($x)'
for (( i = 0; i < "${#email[@]}"; i++ )); do
	list="${email[$i]}"
	w=$(expr 1 + $i)
	tahan=$(expr $i % 10)
	if [[ "$tahan" == 0 ]]; then
		sleep 2
	fi
	checkproxy $list & 
done
rm -rf $proxy.tmp