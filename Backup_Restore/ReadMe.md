# Backup Solution

This project provides an automated backup solution written in Bash. It is designed to back up files from a source directory at specified intervals and handle old backups by keeping a maximum number of backups. It also includes functionality to restore from previous backups.

# Folder Structure

backup_solution/
├── backupd.sh         # Script to perform the backup
├── restore.sh         # Script to restore from previous backups
├── Makefile           # Makefile to automate the backup and restore processes
├── README.md          # Project documentation
└── testing_dir/       # Example source directory to test backup and restore

# Prerequisites

Before running the backup solution, ensure that you have the following installed on your Ubuntu system:

   1. Bash: This solution is written in Bash, which is typically pre-installed on most Linux distributions.

   2. Make: The Makefile is used to automate the execution of backup and restore operations. Install it by running:
    sudo apt update
    sudo apt install make
    
# Step-by-Step Instructions
1. Run the Backup Solution

You can run the backup solution using the provided Makefile, which automates the process of running the backup script.
Step 1: Setup the Source and Backup Directories

You need a source directory that contains the files you want to back up. You can create one manually or use the example testing_dir provided.

   1. Example source directory: testing_dir/
   2. Example backup directory: backup_dir/

If backup_dir/ does not exist, it will be automatically created by the Makefile.
Step 2: Run the Backup Using Makefile

To initiate the backup process, use the Makefile to run the backup script: make run-backup
   
This will:

   1. Create backups of the files in the source directory.
   2. Store them in the specified backup directory (backup_dir/).
   3. Retain a maximum number of backups as configured in the Makefile.

Step 3: Manual Backup (Alternative)

Alternatively, you can run the backup script manually by providing the necessary arguments: ./backupd.sh /path/to/source_dir /path/to/backup_dir 10 5
Where:

    1. /path/to/source_dir: The source directory to back up.
    2. /path/to/backup_dir: The directory where backups will be stored.
    3. 10: The interval (in seconds) between backups.
    4. 5: The maximum number of backups to retain.
    
2. Restore from a Backup

To restore from a backup, use the restore.sh script. It allows you to select a backup to restore from and replace the current files in the source directory with the selected backup.
Run the Restore Script: ./restore.sh /path/to/source_dir /path/to/backup_dir
This will prompt you to choose a backup version to restore.

3. Clean the Backup Directory

To remove all backups, including the backup directory, run the following command: make clean
This will delete all backups and the backup directory.

  
   



