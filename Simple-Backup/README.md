# Simple-Backup

A simple and robust bash script for performing automated backups of files and directories to a remote server using rsync, with logging capabilities.

## Features

*   **Automated Backups:** Uses `rsync` for efficient and incremental backups.
*   **Logging:** Detailed logs of backup operations, including success and failure, are stored in a specified log file.
*   **Cron Scheduling:** Designed to be easily scheduled with `cron` for regular, unattended backups.

## Prerequisites

Before using this script, ensure you have the following installed on your system:

*   **`bash`**: The script is written in Bash.
*   **`rsync`**: For efficient file synchronization.
*   **`ssh`**: For secure communication with the remote server.

## Installation

1.  **Clone the repository (or download the files):**

    ```bash
    git clone https://github.com/yourusername/Simple-Backup.git
    cd Simple-Backup
    ```

2.  **Make the backup script executable:**

    ```bash
    chmod +x backup.sh
    ```

## Usage

Edit the `backup.sh` file to configure your backup settings:

```bash
#!/bin/bash

# Variables

SOURCE_DIR="/root/backup"
LOG_FILE="backup.log"
REMOTE_HOST="root@192.168.1.100"
REMOTE_DIR="/root/"
DATE=$(date +"%Y%m%d%H%M%S")

# Function to perform backup

perform_backup() {
    rsync -avz "$SOURCE_DIR/" "$REMOTE_HOST:$REMOTE_DIR" > "$LOG_FILE" 2>&1
    if [ $? -eq 0 ]; then
        echo "Backup successful: $DATE" >> "$LOG_FILE"
    else
        echo "Backup failed: $DATE" >> "$LOG_FILE"
    fi
}

# Main execution

perform_backup
```

*   **`SOURCE_DIR`**: The absolute path to the directory you want to back up.
*   **`LOG_FILE`**: The absolute path where the backup logs will be stored. (e.g., `/var/log/simple-backup.log`)
*   **`REMOTE_HOST`**: The SSH user and IP address/hostname of your remote backup server (e.g., `user@your_remote_server.com`).
*   **`REMOTE_DIR`**: The absolute path on the remote server where your backups will be stored.

To run the backup script manually:

```bash
./backup.sh
```

## Scheduling with Cron

To automate your backups, schedule the `backup.sh` script to run periodically using cron.

1.  **Open your crontab for editing:**

    ```bash
    crontab -e
    ```

2.  **Add the cron job:**

    Add the following line to your crontab file. Make sure to replace `/root/bash-scripting/backup.sh` with the actual absolute path to your `backup.sh` script.

    ```cron
    0 2 * * * /root/bash-scripting/backup.sh
    ```

    This example will run the backup daily at 2:00 AM.

## Troubleshooting & Tips

*   **Permissions Errors:** Ensure the user running the script has read access to `SOURCE_DIR` and write access to `LOG_FILE` and any local directories referenced by the cron job.
*   **SSH Problems:** Run `ssh user@remote_host` manually to verify that the connection works and that any key-based authentication is set up properly.
*   **Rsync verbose logs:** The script uses `-avz`; if you need more detail, you can edit the `rsync` command inside `backup.sh` (e.g. add `--progress` or `--delete` as required).
*   **Log rotation:** Because logs can grow large, consider adding a logrotate configuration or cron job to rotate/clean `LOG_FILE` periodically.

## Advanced Configuration

The default `backup.sh` contains a simple `rsync` call. You may customize it directly, for instance:

```bash
# inside backup.sh
rsync -avz --delete --exclude='*.tmp' "$SOURCE_DIR/" "$REMOTE_HOST:$REMOTE_DIR" \
    >> "$LOG_FILE" 2>&1
```

Be careful when using `--delete`; it will remove files on the remote side that no longer exist locally.

## Contribution

Contributions, bug reports, and pull requests are welcome.

1.  Fork the repository.
2.  Create a branch for your change: `git checkout -b feature/my-change`.
3.  Commit your changes and push to your fork.
4.  Open a pull request describing your enhancements.

Please follow the existing shell style and keep scripts idempotent.

## Contact & Support

For questions or support, please open an issue on the GitHub repository or contact the maintainer at `your_email@example.com`.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.