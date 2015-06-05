#!/bin/bash

# goto 1.0.0
# Resolves vhosts to allow easy directory navigation
# All rights reserved to Harold Cohen
# Licensed under the MIT license
# mail me @ : ubuntu01@harold-cohen.com
# github : Hashtivist

Vhosts=()
Vpaths=()

function gH(){
	
	local virtualhosts=$(ls /etc/apache2/sites-available)
	for x in $virtualhosts
	do
		vct=$(cat /etc/apache2/sites-available/"$x")
		for line in "$vct"
		do
			local pvar=$( echo "$line" | grep "DocumentRoot" | sed -re 's/DocumentRoot//g' | sed -e 's/^[ \t]*//' )
			local vvar=$( echo "$line" | grep "ServerName" | sed -re 's/ServerName//g' | sed -e 's/^[ \t]*//' )
			Vhosts+=("$vvar")
			Vpaths+=("$pvar")
		done
		
	done

}

function goto(){

	gH
	count=0

	for h in "${Vhosts[@]}"
	do
		if [ "$h" = "$1" ]
		then
			local return="${Vpaths[$count]}"
		fi
		((count+=1))
	done

	echo "$return"

	
}

cd $(goto "$1")



