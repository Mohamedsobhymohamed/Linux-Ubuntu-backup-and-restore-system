SHELL := /bin/bash
SOURCE_DIR := testing_dir           
BACKUP_DIR := backup_dir         
INTERVAL := 10                   
MAX_BACKUPS := 5                 
BACKUP_SCRIPT := ./backupd.sh     
RESTORE_SCRIPT := ./restore.sh    

.PHONY: pre-build
pre-build:
	@echo "Creating backup directory if it doesn't exist..."
	@mkdir -p $(BACKUP_DIR)

.PHONY: run-backup
run-backup: pre-build
	@echo "Running the backup script..."
	@$(BACKUP_SCRIPT) $(SOURCE_DIR) $(BACKUP_DIR) $(INTERVAL) $(MAX_BACKUPS)

.PHONY: restore-backup
restore-backup:
	@echo "Restoring the backup..."
	@$(RESTORE_SCRIPT) $(SOURCE_DIR) $(BACKUP_DIR)

.PHONY: clean
clean:
	@echo "Cleaning up the backup directory..."
	@rm -rf $(BACKUP_DIR)
	@echo "Backup directory cleaned."

all: run-backup

