#!/bin/bash

# Backup script
# This script copies files from a local directory to a remote server using rsync
# and logs whether the backup operation was successful or failed.

# Variables

SOURCE_DIR="/root/backup"        # Local directory that will be backed up
LOG_FILE="backup.log"            # File where backup logs will be saved
REMOTE_HOST="root@192.168.1.100" # Remote server username and IP
REMOTE_DIR="/root/"              # Destination directory on the remote server
DATE=$(date +"%Y%m%d%H%M%S")     # Timestamp used for logging


# Function to perform backup
perform_backup() 
{
    # Use rsync to copy files from SOURCE_DIR to the remote server
    rsync -avz "$SOURCE_DIR/" "$REMOTE_HOST:$REMOTE_DIR" > "$LOG_FILE" 2>&1

    # Check the exit status of rsync command
    if [ $? -eq 0 ]; then
        echo "Backup successful: $DATE" >> "$LOG_FILE"   # Log success message
    else
        echo "Backup failed: $DATE" >> "$LOG_FILE" >> "$LOG_FILE"   # Log failure message
    fi
}

# Run the backup function
perform_backup