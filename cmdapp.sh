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
		#complete cpu information
		cci=$(lscpu)
		#number of active processes 
		nap=$(ps aux --no-headers | wc -l)
		#15 first processes with highest memory usage
		hmu=$(ps aux | sort -rnk 4 | head -15)
		echo "$cci"
		echo "$nap"
		echo "$hmu"
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
