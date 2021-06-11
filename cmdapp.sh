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
		echo -e "${CYAN}system general information${NC}";
		#overall cpu information
		oci=$(cat /proc/cpuinfo | head -n 9 | tail -n 8)
		#name and version of os
		nvos=$(hostnamectl | grep "Operating System" | cut -d ':' -f 2)
		#kernel specification	
		kn=$(uname --kernel-name)
		kr=$(uname --kernel-release)
		kv=$(uname --kernel-version)
		#os distro
		osd=$(cat /etc/*-release | grep "DISTRIB_ID" | cut -d '=' -f 2)
		#desktop environment 
		de=$(echo $XDG_CURRENT_DESKTOP | cut -d ':' -f 2)
		if [ $de == "GNOME" ]
		then
			gn=1
			gv=$(gnome-shell --version | cut -d ' ' -f 3)
		else
			gn=0
		fi
		#number of active processes 
		nap=$(ps aux --no-headers | wc -l)
		#15 top processes with highest memory usage
		headers=$(ps aux | head -n 1)
		hmu=$(ps auxc | sort -rnk 4 | head -15)
		echo -e "${RED}overall cpu information:\n${NC}$oci"
	       	echo -e "${RED}name and version of operating system:${NC}$nvos" 
		echo -e "${RED}kernel specification\n\tname: ${NC}$kn\n\t${RED}release: ${NC}$kr\n\t${RED}version: ${NC}$kv"
		echo -e "${RED}distro of operating system: ${NC}$osd"
		echo -e "${RED}desktop environment: ${NC}$de"
		if [ $gn -eq 1 ]
		then
			echo -e "\t${RED}gnome version: ${NC}$gv" 
		fi
		echo -e "${RED}number of active processes in this system: ${NC}$nap"
		echo -e "${RED}15 top processes with highers memory usage:${NC}\n$headers\n$hmu"
		;;

		"ssi" )  #system security info.
		echo -e "${CYAN}System Security Information${NC}";
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
