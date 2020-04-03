#!/bin/bash
set -e;
cd /maps;
mkdir temp;
cd temp;

# Setup
apt-get update;
apt-get install -y software-properties-common \
build-essential \
make \
git \
libz-dev \
sqlite3 \
libsqlite3-dev \
unzip \
python-pip \
python3-pip \
python3.6-dev \
curl;
apt-get update;

# Install GDAL
add-apt-repository -y ppa:ubuntugis/ppa;
apt-get update;
apt-get install -y gdal-bin python3-gdal;

# Install Tippecanoe
git clone https://github.com/mapbox/tippecanoe.git;
cd tippecanoe;
make -j;
make install;
cd ..;

# Conversion
curl -L -O https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/50m_cultural.zip;
unzip 50m_cultural.zip -d map_data
chmod +r map_data/*;

# Build Up Countries (countries)
#ogr2ogr -f 'ESRI Shapefile' -update -append Countries.geojson ne_50m_admin_0_countries_lakes.shp -skipfailures -nln merge
ogr2ogr -f GeoJSON countries.geojson map_data/ne_50m_admin_0_countries_lakes.shp;

# Build Up Land Borders (land-border-country)
# ogr2ogr -f 'ESRI Shapefile' -update -append Borders.geojson ne_50m_admin_0_countries_lakes.shp -skipfailures -nln merge
ogr2ogr -f GeoJSON  land-border-country.geojson map_data/ne_50m_admin_0_boundary_lines_land.shp;

# Build Up States (state)
# ogr2ogr -f 'ESRI Shapefile' -update -append Borders.geojson ne_50m_admin_0_countries_lakes.shp -skipfailures -nln merge
ogr2ogr -f GeoJSON  state.geojson map_data/ne_50m_admin_1_states_provinces_lines.shp;

cd ..;

# Generate Tiles
tippecanoe -z6 -e world-tiles --no-tile-compression --coalesce-densest-as-needed --extend-zooms-if-still-dropping temp/countries.geojson land-border-temp/country.geojson temp/state.geojson;

rm -rf temp;

exit;