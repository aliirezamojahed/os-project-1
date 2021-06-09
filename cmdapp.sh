#!/bin/bash

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
		#overall cpu information
		oci=$(cat /proc/cpuinfo)
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
		#number of active processes 
		nap=$(ps aux --no-headers | wc -l)
		#15 top processes with highest memory usage
		hmu=$(ps aux | sort -rnk 4 | head -15)
		echo -e "overall cpu information:\n$oci"
		echo -e "name and version of operating system:$nvos" 
		echo -e "kernel specification\nname: $kn\nrelease: $kr\nversion: $kv"
		echo -e "distro of operating system: $osd"
		echo -e "desktop environment: $de"
		echo -e "number of active processes in this system: $nap"
		echo -e "15 top processes with highers memory usage:\n$hmu"
		;;
		"ssi" )  #system security info.
		echo "system security information";
		#TODO
		;;
		"shi" )  #system hardware info.
		echo "system hardware information";
		#TODO
		;;
		* )  #if param is not any of abow
		echo "unknown parameter!";
		;;	
	esac
done
