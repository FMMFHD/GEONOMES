DBHOST="127.0.0.1"
DBPORT="5432"
DBUSER="airq"

echo "sudo -u postgres psql -c 'GRANT pg_read_server_files TO airq'"
sudo -u postgres psql -c 'GRANT pg_read_server_files TO airq'

cd ~/
mkdir tmp_files
cd tmp_files

mypath=`pwd`

echo $mypath

sudo -u postgres dropdb GEONAME_DB

echo "sudo -u postgres createdb -O airq GEONAME_DB"
sudo -u postgres createdb -O airq GEONAME_DB

echo "sudo -u postgres psql -d GEONAME_DB -c 'CREATE EXTENSION postgis;'"
sudo -u postgres psql -d GEONAME_DB -c 'CREATE EXTENSION postgis;'

echo "sudo -u postgres psql -d GEONAME_DB -c 'GRANT ALL ON geometry_columns TO PUBLIC;'"
sudo -u postgres psql -d GEONAME_DB -c 'GRANT ALL ON geometry_columns TO PUBLIC;'

echo "sudo -u postgres psql -d GEONAME_DB -c 'GRANT ALL ON spatial_ref_sys TO PUBLIC;'"
sudo -u postgres psql -d GEONAME_DB -c 'GRANT ALL ON spatial_ref_sys TO PUBLIC;'

echo "sudo -u postgres psql -d GEONAME_DB -c 'GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO airq;'"
sudo -u postgres psql -d GEONAME_DB -c 'GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO airq;'


wget -O ./PT https://download.geonames.org/export/dump/PT.zip

unzip PT

chmod a+rX $mypath $mypath/PT.txt



psql -e -U $DBUSER -d GEONAME_DB <<EOT

create table geoname (
    geonameid   int,
    name varchar(200),
    asciiname varchar(200),
    alternatenames text,
    latitude float,
    longitude float,
    fclass char(1),
    fcode varchar(10),
    country varchar(2),
    cc2 varchar(120),
    admin1 varchar(20),
    admin2 varchar(80),
    admin3 varchar(20),
    admin4 varchar(20),
    population bigint,
    elevation int,
    gtopo30 int,
    timezone varchar(40),
    moddate date
);

copy geoname (geonameid,name,asciiname,alternatenames,latitude,longitude,fclass,fcode,country,cc2,admin1,admin2,admin3,admin4,population,elevation,gtopo30,timezone,moddate) from '$mypath/PT.txt' null as '';

SELECT AddGeometryColumn ('public','geoname','the_geom',4326,'POINT',2);

UPDATE geoname SET the_geom = ST_PointFromText('POINT(' || longitude || ' ' || latitude || ')', 4326);

CREATE INDEX idx_geoname_the_geom ON public.geoname USING gist(the_geom);
 
EOT

cd ~/
rm -r ./tmp_files