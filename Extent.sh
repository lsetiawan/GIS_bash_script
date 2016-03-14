#!/bin/bash
########## Extent Extraction of Polygons ##################
########## by Landung Setiawan 3/11/2016 ##################

shapefiles=(*.shp) # Retrieve Shapefiles in folder

ogrinfo ${shapefiles[0]} -fields=YES -sql "SELECT DISTINCT HUC8_NAME from drb_huc8_epsg4326" | grep "HUC8_NAME (String)" >> HUC8_NAME.txt #grab the values of HUC8_NAME column 

## Format the Grep Result to get just the names
sed -i -e 's/HUC8_NAME //g' HUC8_NAME.txt
sed -i -e 's/ (String) //g' HUC8_NAME.txt
sed -i -e 's/ = //g' HUC8_NAME.txt
##############################################

## Make array of names and write to a text file
getArray() {
	names=(); # Create array 
	while IFS= read -r line # Read a line
		do
			names+=("$line"); # Append line to the array
		done < "$1" ;
	}
getArray "HUC8_NAME.txt"
################################################

## Perform extent extraction and output to textfile
for name in "${names[@]}"
	do
		field="HUC8_NAME='"
		value=$name
		end="'"
		combine=$field$value$end
		
		ogr2ogr -where "$combine" subset.shp ${shapefiles[0]}
		ogrinfo -so subset.shp subset | grep Extent >> extent.txt
		sed -i -e "s/Extent/$name/g" extent.txt
		rm subset.*
		
	done
#################################################

## Formatting the text file	
sed -i -e 's/:/,/g' extent.txt
sed -i -e 's/(//g' extent.txt
sed -i -e 's/)//g' extent.txt
sed -i -e 's/ - /,/g' extent.txt
sed -i -e 's/, /,/g' extent.txt
awk '{printf "%d,%s\n", NR, $0}' extent.txt > extent_num.txt
sed -i -e '1iORDER_PRIORITY,HUC8_NAME,W_LON,S_LAT,E_LON,N_LAT\' extent_num.txt 
##########################################################################

## Save the textfile onto csv
mv extent_num.txt ${shapefiles[0]}.csv

## Remove Unecessary files
rm extent.txt
rm HUC8_NAME.txt




