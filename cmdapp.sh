#!/bin/bash

# text colors
RED='\033[1;31m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

#command line application
for i in $1 $2 $3  # loop over input parameters
do
	if  [ -z $i ]  #if one of input params is null, ignore it
	then
		continue;
	fi
	case $i in
		"sgi" )  #system general information
		echo -e "${CYAN}System General Information${NC}";
		#TODO
		;;
		"ssi" )  #system security info.
		echo -e "${CYAN}System Security Information${NC}";
		#TODO
		# logged in users
		liu=$(users) 
		# active system services
		ass=$(systemctl --type=service --state=active | more) 
		# installed applications
		ip=$(for app in /usr/share/applications/*.desktop ~/.local/share/applications/*.desktop; do app="${app##/*/}"; echo "${app::-8}"; done) 
		# last system upgrade
		lsu=$(grep "upgrade " /var/log/dpkg.log | tail -1) 

		echo -e "${RED}Looged In Users:${NC}\n$liu \n"
		echo -e "${RED}Active System Services:${NC}\n$ass \n"
		echo -e "${RED}Installed Applications:${NC}\n$ip \n"
		echo -e "${RED}Last System Upgrade:${NC}\n$lsu \n"
		;;
		"shi" )  #system hardware info.
		echo -e "${CYAN}System Hardware Information${NC}";
		#TODO
		;;
		* )  #if param is not any of abow
		echo -e "${CYAN}unknown parameter!${NC}";
		;;	
	esac
done
