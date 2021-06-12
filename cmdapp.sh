#!/bin/bash

# Text colors
RED='\033[1;31m'
CYAN='\033[1;36m'
NC='\033[0m' # No color

# Command line application
for i in $1 $2 $3  # Loop over input parameters
do
	if  [ -n $i ]  # if the input param is not null, then process it 
	then	
		case $i in
			"sgi" )  # System General Information
			echo -e "\n${CYAN}System General Information${NC}\n";
			# Overall CPU Information
			oci=$(cat /proc/cpuinfo | head -n 9 | tail -n 8)
			# Name and version of os
			nvos=$(hostnamectl | grep "Operating System" | cut -d ':' -f 2)
			# Kernel specification	
			kn=$(uname --kernel-name)
			kr=$(uname --kernel-release)
			kv=$(uname --kernel-version)
			# OS distro
			osd=$(cat /etc/*-release | grep "DISTRIB_ID" | cut -d '=' -f 2)
			# Desktop environment 
			de=$(echo $XDG_CURRENT_DESKTOP | cut -d ':' -f 2)
			if [ "$de" = "GNOME" ]
			then
				gn=1
				gv=$(gnome-shell --version | cut -d ' ' -f 3)
			else
				gn=0
			fi
			# Number of active processes 
			nap=$(ps aux --no-headers | wc -l)
			# 15 top processes with highest memory usage
			headers=$(ps aux | head -n 1)
			hmu=$(ps auxc | sort -rnk 4 | head -15)
			echo -e "${RED}Overall CPU Information:\n${NC}$oci"
			echo -e "${RED}Name and Version of Operating System:${NC}$nvos" 
			echo -e "${RED}Kernel Specification\n\tname: ${NC}$kn\n\t${RED}Release: ${NC}$kr\n\t${RED}Version: ${NC}$kv"
			echo -e "${RED}Distro of Operating System: ${NC}$osd"
			echo -e "${RED}Desktop Environment: ${NC}$de"
			if [ $gn -eq 1 ]
			then
				echo -e "\t${RED}Gnome Version: ${NC}$gv" 
			fi
			echo -e "${RED}Number of Active Processes: ${NC}$nap"
			echo -e "${RED}15 Top processes with highers memory usage:${NC}\n$headers\n$hmu"
			;;
	
			"ssi" )  # System Security Information
			echo -e "\n${CYAN}System Security Information${NC}\n";
			# Logged In Users
			liu=$(users) 
			# Active System Services
			ass=$(systemctl --type=service --state=active) 
			# Installed Applications
			ip=$(for app in /usr/share/applications/*.desktop ~/.local/share/applications/*.desktop; do app="${app##*/}"; echo "${app::-8}"; done) 
			# Last System Upgrade
			lsu=$(grep "upgrade " /var/log/dpkg.log | tail -1) 
			echo -e "${RED}Looged In Users:${NC}\n$liu\n"
			echo -e "${RED}Active System Services:${NC}\n$ass\n"
			echo -e "${RED}Installed Applications:${NC}\n$ip\n"
			echo -e "${RED}Last System Upgrade:${NC}\n$lsu\n"
			;;
	
			"shi" )  # System Hardware Info.
			echo -e "\n${CYAN}System Hardware Information${NC}\n";
			# CPU Hardware Details
			chd=$(lscpu)
			# Memory Hardware Details
			mhd=$(less /proc/meminfo)
			# USB Devices Details
			udd=$(usb-devices)
			# CPU Usage 
			cu=$(ps --no-headers -eo pcpu | awk '{cpu += $1} END {print cpu}')
			# Memory Usage 
			mu=$(ps --no-headers -eo pmem | awk '{mem += $1} END {print mem}')
			# Disk Usage 
			dus=$(df -h --output=pcent / | tail -n 1)
			echo -e "${RED}CPU Hardware Details:${NC}\n$chd\n"
			echo -e "${RED}Memory Hardware Details:${NC}\n$mhd\n"
			echo -e "${RED}USB Devices Details:${NC}\n$udd\n"
			echo -e "${RED}Resources Usage${NC}"
			echo -e "${RED}\tCPU Usage: ${NC}$cu%"
			echo -e "${RED}\tMemory Usage: ${NC}$mu%"
			echo -e "${RED}\tDisk Usage:${NC}$dus"
			;;
	
			* )  # if param is not any of abow
			echo -e "${CYAN}Unknown Parameter!${NC}";
			;;	
		esac
	fi
done
