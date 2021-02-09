#!/bin/bash


# Seta as cores   
RESET="\033[0m"			# Normal Colour
RED="\033[0;31m" 		# Error / Issues
GREEN="\033[0;32m"		# Successful       
BOLD="\033[01;01m"    		# Highlight
WHITE="\033[1;37m"		# BOLD
YELLOW="\033[1;33m"		# Warning
PADDING="  "
DPADDING="\t\t" 

banner (){ 
    echo -e "\n ${YELLOW}zdumper ${RESET}- Fast Subdmain Enumeration and Search git exposed ${RESET}"
    echo -e " ${BOLD}http://github.com/capuzsec${RESET}\n"
    echo -e "\n ${BOLD}Sources:${RESET}"  
    echo -e "${PADDING}${YELLOW}+${RESET} CrtSH${DPADDING} https://crt.sh" 
    echo -e "${PADDING}${YELLOW}+${RESET} BufferOver${DPADDING} https://dns.bufferover.run"  
    echo -e "${PADDING}${YELLOW}+${RESET} Assetfinder${DPADDING} https://github.com/tomnomnom/assetfinder"  
    echo -e "${PADDING}${YELLOW}+${RESET} Subfinder${DPADDING} https://github.com/projectdiscovery/subfinder\n\n"  
    
}

banner_help (){
    banner
    echo -e  " -h: Help menu"  
    echo -e  " -d or --domain: Set domain"
    echo -e  " -sc or --status-code: Extracts status code\n"
    echo -e  " Use: ./$0 -d target.com -sc 200\n"  
}
 

shttpx (){  
    if [ -z $sc ] 
    then
        sort -u | httpx -silent -content-length -status-code -threads 500 -path /.git/HEAD
    else 
        sort -u | httpx -silent -content-length -status-code -threads 500 -path /.git/HEAD -mc $sc
    fi
}             


while [[ "${#}" -gt 0  ]]; do
args="${1}";
  case "$( echo ${args} | tr '[:upper:]' '[:lower:]' )" in
        # Target
        "-d" | "--domain")
            DOMAIN="${2}"
            shift
            shift
        ;;

        "-sc"|"--status-code")
            sc=${2}
            shift
            shift 
      	;;

        "-h"|"--help") 
            banner_help
            exit
      	;;
    
        *)
            banner_help
            exit
        ;;
    esac
done 
 

if [ -z $DOMAIN ] 
then 
    banner_help
else 
    banner  
    assetfinder ${DOMAIN} | shttpx
    curl -s "https://crt.sh/?q=%25.${DOMAIN}&output=json" | jq -r '.[].name_value' | shttpx
    subfinder -d ${DOMAIN} -silent | shttpx
    curl -s "https://dns.bufferover.run/dns?q=.${DOMAIN}" | jq -r .FDNS_A[] | sed -s 's/,/ /g'  | awk '{ print $2 }'  | shttpx 
fi
