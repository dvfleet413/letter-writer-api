#!/bin/bash

pg_dump -h ec2-52-44-55-63.compute-1.amazonaws.com -p 5432 -U qrzipievkohmtj --password -Fc --no-owner --dbname=d7d5qa8hu582lv > ~/Downloads/territory_counter_backup.sql

echo "pg_dump from heroku complete"

psql -p 5432 --username davidvanfleet --dbname postgres <<-EOSQL
    DROP DATABASE IF EXISTS letter_writer_api_development;
    CREATE DATABASE letter_writer_api_development;
EOSQL

pg_restore -x -p 5432 ~/Downloads/territory_counter_backup.sql -e -O -d letter_writer_api_development

echo "local pg_restore complete"

rm -rf ~/Downloads/territory_counter_backup.sql