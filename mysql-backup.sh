#!/bin/bash

# This script creates a compressed backup archive of the given MySQL table. 
# Set the date format, filename and the directories where your backup files will be placed and which directory will be archived.
NOW=$(date +"%Y-%m-%d-%H%M")
FILE="example.org.$NOW.tar"
BACKUP_DIR="/home/username/backups"

# MySQL database credentials
DB_USER="mysqluser"
DB_PASS="mysqlpass"
DB_NAME="example_org"
DB_FILE="example.org.$NOW.sql"

# Tar transforms for better archive structure.
DB_TRANSFORM='s,^home/username/backups,database,'

# Create the archive and the MySQL dump
mysqldump -u$DB_USER -p$DB_PASS -$DB_NAME > $BACKUP_DIR/$DB_FILE

# Append the dump to the archive, remove the dump and compress the whole archive.
tar --append --file=$BACKUP_DIR/$FILE --transform $DB_TRANSFORM $BACKUP_DIR/$DB_FILE
rm $BACKUP_DIR/$DB_FILE
gzip -9 $BACKUP_DIR/$FILE