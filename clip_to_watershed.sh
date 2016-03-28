#!/bin/bash

#Bash script to automate clipping

getNames() {
	names=(); # Create array 
	while IFS= read -r line # Read a line
		do
			names+=("$line"); # Append line to the array
		done < "$1" ;
	}

getbbox() {
	bbox=(); # Create array 
	while IFS= read -r line # Read a line
		do
			bbox+=("$line"); # Append line to the array
		done < "$1" ;
	}

getNames "czonames.txt"
getbbox "boundingcoord.txt"

cd './MOD13A2_TIF_epsg4326/'
tif=(*.tif)

for dir in ${!names[@]}
	do
		mkdir ./${names[dir]}
		echo "Working on ${names[dir]}"
		for img in ${!tif[@]}
			do 
				gdalwarp -dstalpha -te ${bbox[dir]} ${tif[img]} ./${names[dir]}/${tif[img]}_${names[dir]}.tif 
			done 
	done

cd '../'
pwd