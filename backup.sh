#!/bin/bash
dbnames=`mysql --user=root --password=theTav*369 -se "show databases;"`
CURRENTDATE=`date +"%d-%m-%Y"`
CURRENTDATETIME=`date +"%Y-%m-%d-%T"`

mkdir /home/liashko/OneDrive/Site_Backups/${CURRENTDATETIME}
mkdir /home/liashko/OneDrive/Site_Backups/${CURRENTDATETIME}/sql
mkdir /home/liashko/OneDrive/Site_Backups/${CURRENTDATETIME}/data
SQL_DIR="/home/liashko/OneDrive/Site_Backups/${CURRENTDATETIME}/sql"
DATA_DIR="/home/liashko/OneDrive/Site_Backups/${CURRENTDATETIME}/data"

for x in $dbnames;
do
    if [ $x == "mysql" ] || [ $x == "information_schema" ] || [ $x == "performance_schema" ];
    then
        continue
    else
        `mysqldump --user=root --password=theTav*369 ${x} > ${SQL_DIR}/${x}.sql`
        #echo "There is a database called $x"
    fi
done;

for d in /var/www/* ; do
    NAME=$(basename ${d})    
    tar cf - ${d} -P | pv -s $(du -sb ${d} | awk '{print $1}') | xz -9 --threads=2 > ${DATA_DIR}/${NAME}.tar.xz
done
