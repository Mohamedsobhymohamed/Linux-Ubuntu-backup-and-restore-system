#!/bin/bash

if [ $# -ne 2 ]
then
  echo "$0 needs two arguments: dir backupdir"
  exit 1
fi

dir=$1
backupdir=$2

if [ ! -d "$backupdir" ]
then
  echo "Backup directory '$backupdir' does not exist."
  exit 1
fi

backups=($(ls -1 "$backupdir" | grep -v "directory-info.last" | sort))

if [ ${#backups[@]} -eq 0 ]
then
  echo "No backups available to restore."
  exit 1
fi

current_index=$((${#backups[@]} - 1))

restore_backup() {
  timestamp=$1
  cp -r "$backupdir/$timestamp/"* "$dir/"
  echo "Restored to version: $timestamp"
}

while true
do
  echo "Current backup is: ${backups[$current_index]}"
  echo "Please, Choose an option:"
  echo "1. Restore to the previous version"
  echo "2. Restore to the next version"
  echo "3. Exit"
  read -p "Your choice: " choice

  case $choice in
    1) 
      if [ $current_index -gt 0 ]
      then
        current_index=$((current_index - 1))
        restore_backup "${backups[$current_index]}"
        echo "Restored to a previous version: ${backups[$current_index]}"
      else
        echo "No older backup available to restore."
      fi
      ;;
    2) 
      if [ $current_index -lt $((${#backups[@]} - 1)) ]
      then
        current_index=$((current_index + 1))
        restore_backup "${backups[$current_index]}"
        echo "Restored to a next version: ${backups[$current_index]}"
      else
        echo "No newer backup available to restore."
      fi
      ;;
    3) 
      echo "Exiting the restore system..."
      break
      ;;
    *) 
      echo "Invalid choice, please try again."
      ;;
  esac
done

