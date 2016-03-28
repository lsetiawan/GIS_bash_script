# GIS_bash_script
# by Landung Setiawan
The bash scripts contained in this repository is used for either raster or vector manipulation. It is an automated process specific for MODIS(EVI) and Delaware River Basin study area. 

The scripts are dependant on a list of packages:
* GDAL/OGR
* pyModis
* python 2.7

## Extent.sh
The purpose of this script is to extract the bounding box of polygons contained within the Delaware River Basin HUC8 Polygon. These polygons are used for the [Christina River Basin] (http://viz.criticalzone.org/Christina) Project.

```Bash
Ogr2ogr reprojection
ogr2ogr -t_srs EPSG:4326 -s_srs EPSG:26918 ~/Documents/DelawareWatershed/ ~/Documents/DelawareWatershed/shapefiles/drb_huc8_polygon.shp
mv drb_huc8_polygon.shp drb_huc8_epsg4326.shp
mv drb_huc8_polygon.shp drb_huc8_epsg4326.prj
mv drb_huc8_polygon.shp drb_huc8_epsg4326.shx
mv drb_huc8_polygon.shp drb_huc8_epsg4326.dbf
```

**NOTE** The script below assumes that shapefiles are reprojected already and names as drb_huc8_epsg4326.* 
