#!/bin/bash

# Log management script
# This script rotates log files if they exceed a specific size
# and deletes old compressed logs after a certain number of days.


# Variables

LOG_DIR="/var/log/myapp"        # Directory where log files are stored
MAX_LOG_SIZE=10485760           # Maximum log size before rotation (10 MB)
MAX_LOG_AGE=30                  # Delete compressed logs older than 30 days
DATE=$(date +"%Y%m%d%H%M%S")    # Timestamp used when renaming rotated logs



# Function to rotate logs if their size exceeds the limit

rotate_logs() {
    for log_file in "$LOG_DIR"/*.log; do
        # Check if the log file size is greater than MAX_LOG_SIZE
        if [ $(stat -c%s "$log_file") -gt $MAX_LOG_SIZE ]; then
            mv "$log_file" "$log_file.$DATE"     # Rename the log file with timestamp
            gzip "$log_file.$DATE"               # Compress the rotated log file
            echo "Log Rotated: $log_file"        # Print message indicating rotation
        fi
    done
}


# Function to delete old compressed logs

delete_old_logs() {
    # Find .gz files older than MAX_LOG_AGE days and delete them
    find "$LOG_DIR" -name "*.gz" -type f -mtime +$MAX_LOG_AGE -exec rm {} \;
    echo "Old logs deleted."
}


# Run the functions
rotate_logs
delete_old_logs