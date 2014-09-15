#!/bin/bash

# !!!You have to install and setup s3cmd first!!!
# http://s3tools.org

# Download database and run migrations

# Without arguments you will get today db
# With argument you can control for which date you want to download db
## e.g. 2013.01.10

if [ "$#" == 0 ]
then
  selected_date=$(date +%Y.%m.%d);
else
  selected_date=$1
fi

cd /data/tmp

echo "Removing previously downladed backup"
rm -rf {{ pillar['app']['name'] }}_database

echo "Downloading backup data for ${selected_date}"
timestamp="${selected_date}*"
database_name="{{ pillar['app']['name'] }}_production_$(echo ${selected_date} | sed 's/\.//g')"

s3cmd get --skip-existing "s3://{{ pillar['app']['name'] }}-live-{{ pillar['app']['company'] }}/DatabaseBackups/{{ pillar['app']['name'] }}_database/${timestamp}/{{ pillar['app']['name'] }}_database.tar"

selected_backup=$(ls -dt ${timestamp} | head -1)

echo "There were two backups, selecting ${selected_backup}"

echo "Unpacking backup data"
tar -xvf "${selected_backup}/{{ pillar['app']['name'] }}_database.tar"

echo "Creating database"
mysqladmin -f drop $database_name
mysqladmin create $database_name

echo "Loading data into database"
zcat {{ pillar['app']['name'] }}_database/databases/MySQL.sql.gz | mysql $database_name

rm -rf {{ pillar['app']['name'] }}_database

echo "Done"
