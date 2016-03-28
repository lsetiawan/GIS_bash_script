#!/bin/bash
## Script to create geoTiff from HDR
cd '/home/lsetiawan/Documents/'
python tile_list.py
sed -i -e "s/', '/,/g" tile_list.txt
sed -i -e "s/\['//g" tile_list.txt
sed -i -e "s/'\]//g" tile_list.txt

tile=$(cat tile_list.txt)


getArray() {
	dates=(); # Create array 
	while IFS= read -r line # Read a line
		do
			dates+=("$line"); # Append line to the array
		done < "$1" ;
	}
getArray "date_list_fol_copy.txt"

dates1=(); # Create array 
while IFS= read -r line # Read a line
	do
		dates1+=("$line"); # Append line to the array
	done < "date_list_d_copy.txt" 

mkdir ./MOD13A2.006
for date in ${!dates[@]}
	do
		echo "Working on ${dates[date]}"
		mkdir ./MOD13A2.006/"${dates[date]}"
	done
	
for j in ${!dates1[@]}
	do
		echo "Working on ${dates1[j]}"
		echo ${dates1[j]}
		echo ${dates1[j+=1]}
		current=${dates[j-=1]}
		$(modis_download.py -r -p MOD13A2.006 -t $tile -f ${dates1[j]} -e ${dates1[j+=1]} ./MOD13A2.006/"${dates[j-=1]}")
		cd ./MOD13A2.006/$current
		pwd
		hdffiles=(*.hdf) 
		for k in ${!hdffiles[@]}
			do
				gdal_translate -of GTiff HDF4_EOS:EOS_GRID:\""${hdffiles[k]}"\":MODIS_Grid_16DAY_1km_VI:1\ km\ 16\ days\ EVI ./"${hdffiles[k]}".tif
			done
		rm *.hdf
		rm *.hdf.xml
		mkdir ~/Documents/MOD13A2_TIF/
		$(gdal_merge.py -o ~/Documents/MOD13A2_TIF/"MOD13A2_$current".tif ./*.tif)
		cd '/home/lsetiawan/Documents/'
		pwd
	done
rm tile_list.txt

#hdffiles=(*.hdf) 

#for i in ${!hdffiles[@]}
#	do
#		gdal_translate -of GTiff HDF4_EOS:EOS_GRID:\""${hdffiles[i]}"\":MODIS_Grid_16DAY_1km_VI:1\ km\ 16\ days\ EVI ~/Documents/2000_03_21/"${hdffiles[i]}".tif
#	done

#rm tile_list.txt
#gdalwarp -t_srs EPSG:4326 ~/Documents/MOD13A2_2000_03_21.tif ~/Documents/MOD13A2_2000_03_21_epsg4326.tif
### gdalwarp -cutline Study_Area.shp -crop_to_cutline -dstalpha ~/Documents/out_epsg4326.tif cutout_epsg4326.tif



