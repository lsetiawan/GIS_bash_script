# GIS_bash_script
########## Extent Extraction of Polygons ##################
########## by Landung Setiawan 3/11/2016 ##################

##### Script Log ############
# date     | Task                     |Name               
#3/11/2016 | Script is created        |Landung Setiawan 
#######################################################

## Ogr2ogr reprojection
#ogr2ogr -t_srs EPSG:4326 -s_srs EPSG:26918 ~/Documents/DelawareWatershed/ ~/Documents/DelawareWatershed/shapefiles/drb_huc8_polygon.shp
# mv drb_huc8_polygon.shp drb_huc8_epsg4326.shp
# mv drb_huc8_polygon.shp drb_huc8_epsg4326.prj
# mv drb_huc8_polygon.shp drb_huc8_epsg4326.shx
# mv drb_huc8_polygon.shp drb_huc8_epsg4326.dbf

####!!!!NOTE!!! The script below assumes that shapefiles are reprojected already and names as drb_huc8_epsg4326.* ######################
