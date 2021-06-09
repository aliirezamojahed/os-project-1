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
		echo "system general information";
		#TODO
		;;
		"ssi" )  #system security info.
		echo "system security information";
		#TODO
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
		#memory usage 
		mu=$(free -h)
		#cpu usage 
		cu=$(ps --no-headers -eo pcpu | awk '{cpu += $1} END {print cpu}')
		#disk usage 
		dus=$(df -h /)
		echo -e "${RED}CPU Hardware Details:${NC}\n$chd \n"
		echo -e "${RED}Memory Hardware Details:${NC}\n$mhd \n"
		echo -e "${RED}USB devices details:${NC}\n$udd \n"
		echo -e "memory usage:\n$mu"
		echo -e "cpu usage: $cu%"
		echo -e "disk usage:\n$dus"
		;;
		* )  #if param is not any of abow
		echo "unknown parameter!";
		;;	
	esac
done
