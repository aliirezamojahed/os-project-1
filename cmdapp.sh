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
		# CPU hardware details
		chd=$(lscpu)
		# Memory hardware details
		mhd=$(less /proc/meminfo)
		# USB devices details
		udd=$(usb-devices)
		#cpu usage 
		cu=$(ps --no-headers -eo pcpu | awk '{cpu += $1} END {print cpu}')
		#memory usage 
		mu=$(ps --no-headers -eo pmem | awk '{mem += $1} END {print mem}')
		#disk usage 
		dus=$(df -h --output=pcent / | tail -n 1)
		echo -e "${RED}CPU Hardware Details:${NC}\n$chd \n"
		echo -e "${RED}Memory Hardware Details:${NC}\n$mhd \n"
		echo -e "${RED}USB devices details:${NC}\n$udd \n"
		echo -e "${RED}cpu usage: ${NC}$cu%"
		echo -e "${RED}memory usage: ${NC}$mu%"
		echo -e "${RED}disk usage:${NC}$dus"
		;;
		* )  #if param is not any of abow
		echo -e "${CYAN}unknown parameter!${NC}";
		;;	
	esac
done
