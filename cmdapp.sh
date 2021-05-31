#!/bin/bash

for i in $1 $2 $3
do
	if  [ -z $i ] 
	then
		continue;
	fi
	case $i in
		"sgi" ) 
		#system general info.
		echo "system general information";
		;;
		"ssi" )
		#system security info.
		echo "system security information";
		;;
		"shi" )
		#system hardware info.
		echo "system hardware information";
		;;
		* )
		echo "unknown parameter!";
		;;	
	esac
done
