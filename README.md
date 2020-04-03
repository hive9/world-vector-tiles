# World Vector Tiles

This repo contains a world map in vector tiles sourced from [Natural Earth Data](https://www.naturalearthdata.com/) and also includes the scripts utilised to generate them.

## Generating Tiles
Generating tiles are performed with-in a docker container and utilise tools from both GDAL and Mapbox. Conversions are performed from Natural Earths vector shapefiles into GeoJSON using GDAL's `ogr2ogr`, this is then passed to Mapbox's tippecanoe which then compiles them into the required folder structure and tile format.

## Natural Earth Data
The map data used to generate this map can found at [Natural Earth Data's](https://www.naturalearthdata.com/)  website. You can also find licensing information about the data source here [Natural Earth Data Terms of Use](https://www.naturalearthdata.com/about/terms-of-use/).

![](https://www.naturalearthdata.com/wp-content/uploads/2009/08/NEV-Logo-color_sm.png)