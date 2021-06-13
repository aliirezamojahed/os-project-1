#!/bin/bash

# Text colors
RED='\033[1;31m'
CYAN='\033[1;36m'
NC='\033[0m' # No color

# Command line application
for i in $1 $2 $3; do  # Loop over input parameters
	if  [ -n $i ]; then  # If the input param is not null, then process it 
		if [ "$i" != "$1" ]; then
			echo -e "${RED}\t\t************************************************${NC}"
		fi
		case $i in
			"sgi" )  # System General Information
			echo -e "\n${CYAN}System General Information${NC}\n";
			# Overall CPU Information
			oci=$(cat /proc/cpuinfo | head -n 9 | tail -n 8)
			# Name and version of os
			nvos=$(hostnamectl | grep "Operating System" | cut -d ':' -f 2)
			# Kernel Specification	
			kn=$(uname --kernel-name)
			kr=$(uname --kernel-release)
			kv=$(uname --kernel-version)
			# OS Distro
			osd=$(cat /etc/*-release | grep "DISTRIB_ID" | cut -d '=' -f 2)
			# Desktop Environment 
			de=$(echo $XDG_CURRENT_DESKTOP | cut -d ':' -f 2)
			if [ "$de" = "GNOME" ]; then
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
			echo -e "${RED}Name and Version of Operating System: ${NC}$nvos" 
			echo -e "${RED}Kernel Specification"
			echo -e "\t${RED}Name: ${NC}$kn"
			echo -e "\t${RED}Release: ${NC}$kr"
			echo -e "\t${RED}Version: ${NC}$kv"
			echo -e "${RED}Distro of Operating System: ${NC}$osd"
			echo -e "${RED}Desktop Environment: ${NC}$de"
			if [ $gn -eq 1 ]; then
				echo -e "\t${RED}Gnome Version: ${NC}$gv" 
			fi
			echo -e "${RED}Number of Active Processes: ${NC}$nap"
			echo -e "${RED}15 Top Processes with Highest Memory Usage:${NC}\n$headers\n$hmu\n"
			;;
################################################################################
			"ssi" )  # System Security Information
			echo -e "\n${CYAN}System Security Information${NC}\n";
			# Logged In Users
			liu=$(users) 
			# Active System Services
			ass=$(systemctl --type=service --state=active) 
			# Installed Applications
			files1=/usr/share/applications/*.desktop
			files2=~/.local/share/applications/*.desktop
			ia=$(for app in $files1 $files2; do
	       			app="${app##*/}"; 
				echo "${app::-8}";
		       	     done) 
			# Last System Upgrade
			lsu=$(grep "upgrade " /var/log/dpkg.log | tail -1) 

			echo -e "${RED}Looged In Users:${NC}\n$liu\n"
			echo -e "${RED}Active System Services:${NC}\n$ass\n"
			echo -e "${RED}Installed Applications:${NC}\n$ia\n"
			echo -e "${RED}Last System Upgrade:${NC}\n$lsu\n"
			;;
################################################################################
			"shi" )  # System Hardware Information
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
			dus=$(df --output=pcent / | tail -n 1)

			echo -e "${RED}CPU Hardware Details:${NC}\n$chd\n"
			echo -e "${RED}Memory Hardware Details:${NC}\n$mhd\n"
			echo -e "${RED}USB Devices Details:${NC}\n$udd\n"
			echo -e "${RED}Resources Usage${NC}"
			echo -e "${RED}\tCPU Usage: ${NC}$cu%"
			echo -e "${RED}\tMemory Usage: ${NC}$mu%"
			echo -e "${RED}\tDisk Usage:${NC}$dus\n"
			;;
################################################################################
			* )  # If the param is not any of abow
			echo -e "${CYAN}Unknown Parameter!${NC}";
			;;	
		esac
	fi
done
