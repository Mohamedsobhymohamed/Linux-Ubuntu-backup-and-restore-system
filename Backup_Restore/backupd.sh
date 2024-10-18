#!/bin/bash

if [ $# -ne 4 ]
then
   echo "$0 needs four arguments: dir backupdir interval-secs max-backups"
   exit 1
fi   

dir=$1
backupdir=$2
interval_secs=$3
max_backups=$4

mkdir -p "$backupdir"
ls -lR "$dir" > "$backupdir/directory-info.last"

backup_directory() {
    current_time=$(date +%Y-%m-%d-%H-%M-%S)
    destination="$backupdir/$current_time"
    cp -r "$dir" "$destination"
    echo "Backup created successfully: $destination"
}

cleanup_old_backups() {
    backup_count=$(ls -1 "$backupdir" | grep -v "directory-info.last" | wc -l)

    if [ $backup_count -gt $max_backups ]
    then
        backups_to_delete=$((backup_count - max_backups))
        old_backups=$(ls -1 "$backupdir" | grep -v "directory-info.last" | sort | head -n "$backups_to_delete")
        
        for old_backup in $old_backups
        do
            rm -rf "$backupdir/$old_backup"
            echo "Old backup deleted: $backupdir/$old_backup"
        done
    fi  
}

backup_directory

while true
do
    sleep "$interval_secs"

    ls -lR "$dir" > "$backupdir/directory-info.new"

    if ! cmp -s "$backupdir/directory-info.last" "$backupdir/directory-info.new"
    then
        echo "The Directory has changed"
        
        backup_directory
        
        mv "$backupdir/directory-info.new" "$backupdir/directory-info.last"
        cleanup_old_backups
    else
        echo "No changes happened"
        rm "$backupdir/directory-info.new"
    fi
done 

