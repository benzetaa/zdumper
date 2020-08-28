#!/bin/bash


# Seta as cores 
RED='\033[0;31m' # Red
NC='\033[0m' # No Color
VERDE='\033[0;32m' # Green 
LAZUL='\e[96m' # Ligth Blue 
BOLD='\e[1m' # Bold 
AMARELO='\033[1;33m'
AZUL='\033[1;34m'
# Seta as cores 

banner(){
    clear
    printf "${BOLD}
 @@@@@@@@  @@@  @@@@@@@     @@@@@@@   @@@  @@@  @@@@@@@@@@   @@@@@@@   @@@@@@@@  @@@@@@@   
@@@@@@@@@  @@@  @@@@@@@     @@@@@@@@  @@@  @@@  @@@@@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  
!@@        @@!    @@!       @@!  @@@  @@!  @@@  @@! @@! @@!  @@!  @@@  @@!       @@!  @@@  
!@!        !@!    !@!       !@!  @!@  !@!  @!@  !@! !@! !@!  !@!  @!@  !@!       !@!  @!@  
!@! @!@!@  !!@    @!!       @!@  !@!  @!@  !@!  @!! !!@ @!@  @!@@!@!   @!!!:!    @!@!!@!   
!!! !!@!!  !!!    !!!       !@!  !!!  !@!  !!!  !@!   ! !@!  !!@!!!    !!!!!:    !!@!@!    
:!!   !!:  !!:    !!:       !!:  !!!  !!:  !!!  !!:     !!:  !!:       !!:       !!: :!!   
:!:   !::  :!:    :!:       :!:  !:!  :!:  !:!  :!:     :!:  :!:       :!:       :!:  !:!  
 ::: ::::   ::     ::        :::: ::  ::::: ::  :::     ::    ::        :: ::::  ::   :::  
  :: :: :   :       :        :: :  :    : :  :    :      :     :        : :: ::    :   : :  
" 
}



logica(){
    content_length=$(curl -I $i 2>/dev/null | grep content-length: | awk '{ print $2 }') 
    status_code=$(curl -I $i 2>/dev/null | head -1 | awk '{print $2}')  
 
    case $status_code in 
        200)
            printf "$i ${VERDE}${BOLD}[${status_code}]${NC} ${AZUL}Content-Length: ${AMARELO}${content_length}${NC}"
            echo
        ;;

        30*) 
        
            printf "$i ${LAZUL}${BOLD}[${status_code}]${NC} ${AZUL}Content-Length: ${AMARELO}${content_length}${NC}"
            echo
        ;;

        40*)
            printf "$i ${RED}${BOLD}[${status_code}]${NC} ${AZUL}Content-Length: ${AMARELO}${content_length}${NC}"
            echo
        ;;

        *)
            printf "$i ${RED}${BOLD}[Problema com Domínio ou Sertificado SSL/HTTPS]${NC}"
            echo
        ;;
    esac
    
} 
 

if [ -z $1 ] 
then 
    banner
    printf "\n${BOLD}Twitter: https://twitter.com/CapuzSec${NC} \n"
    printf "${BOLD}${LAZUL}Use ./domains-git.sh target.com${NC}\n\n" 

else 
    banner
     
    $(curl -s "https://dns.bufferover.run/dns?q=.${1}" | jq -r .FDNS_A[] | sed -s 's/,/ /g'  | sort -u  | sed 's#$#/.git/HEAD#g' | awk '{ print $2 }' > target.txt)
    $(curl -s "https://crt.sh/?q=%25.${1}&output=json" | jq -r '.[].name_value' | sort -u | sed 's#$#/.git/HEAD#g' >> target.txt)
 

    # Testando com httpS
    printf "\n${BOLD}${LAZUL}[+] Testando com httpS [+]${NC}\n\n"
    for i in "https://$1/.git/HEAD"
    do 
        logica 
    done

    for i in $(cat target.txt | sed 's/^/https:\/\//')
    do 
        logica 
    done    
    # Testando com httpS

    # Testando com HTTP
    printf "\n${BOLD}${LAZUL}[+] Testando com HTTP [+]${NC}\n\n"
    for i in "http://$1/.git/HEAD"
    do 
        logica 
    done

    for i in $(cat target.txt | sed 's/^/http:\/\//')
    do 
        logica 
    done
    # Testando com HTTP
fi