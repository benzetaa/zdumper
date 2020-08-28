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
 

if [ -z $1 ] 
then 
    banner
    printf "\n${BOLD}Twitter: https://twitter.com/CapuzSec${NC} \n"
    printf "${BOLD}${LAZUL}Use ./domains-git.sh target.com${NC}\n\n" 

else 
    banner
    
    curl -s "https://crt.sh/?q=%25.${1}&output=json" | jq -r '.[].name_value' | sed 's#$#/.git/HEAD#g' | httpx -silent -content-length -status-code 301,302 -timeout 3 -retries 0 -ports 80,8080,443 -threads 500 -title 
    curl -s "https://dns.bufferover.run/dns?q=.${1}" | jq -r .FDNS_A[] | sed -s 's/,/ /g'  | sort -u  | awk '{ print $2 }' | sed 's#$#/.git/HEAD#g' | httpx -silent -content-length -status-code 301,302 -timeout 3 -retries 0 -ports 80,8080,443 -threads 500 -title  

fi