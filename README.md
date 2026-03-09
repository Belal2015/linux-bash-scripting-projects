# Bash Scripting Projects

This repository contains a collection of shell scripts and related resources aimed at automating common system administration tasks on Unix-like systems. Each directory contains a standalone script along with documentation in its own README. The top-level README provides an overview of the available projects.

## Contents

- **backup** – A script that performs filesystem backups.
- **log-rotation** – A utility for rotating log files.
- **monitoring** – A simple system monitoring script.
- **network** – A tool for configuring static IP settings.

## Repository Structure

```
linux-bash-scripts
│
├── backup
│   └── backup.sh
│
├── log-rotation
│   └── log_rotate.sh
│
├── monitoring
│   └── system_monitor.sh
│
├── network
│   └── static_ip_config.sh
│
├── README.md
```

## Project Details

### backup
Path: `backup/backup.sh`

Provides a straightforward mechanism to copy files or directories to a designated backup location. A sample `crontab` example may be provided within the folder to automate the task. Consult the subfolder README for configuration and usage.

### log-rotation
Path: `log-rotation/log_rotate.sh`

Manually rotate and archive log files to conserve disk space. The script can be scheduled via cron and includes options for retention policy. See `log-rotation/README.md` for details.

### monitoring
Path: `monitoring/system_monitor.sh`

Collects and reports basic system statistics such as CPU load, memory usage, and disk utilization. Output can be logged or emailed as needed. The folder's README contains usage examples and parameters.

### network
Path: `network/static_ip_config.sh`

Configures a static IP address on a network interface. Useful for initializing new machines or resetting network settings. Refer to `network/README.md` for command-line options and prerequisites.

## Usage

Each subproject includes its own README with installation and usage instructions. Generally, scripts are executed from the command line with appropriate arguments or scheduled with cron. Ensure you have execution permissions (`chmod +x`) before running.

## Contribution

Feel free to enhance the scripts by adding features, improving portability, or writing tests. Submit pull requests with descriptive commit messages.

## License

Most scripts are released under the MIT License or as noted in the individual directories (see `Simple-Backup/LICENSE`).

---

## 👤 Author

**Belal Mahmoud** - DevOps Engineer

- **GitHub**: [https://github.com/Belal2015](https://github.com/Belal2015)
- **LinkedIn**: [https://www.linkedin.com/in/belal-mahmoud-devops/](https://www.linkedin.com/in/belal-mahmoud-devops/)
- **Email**: belalmahmoud8183@gmail.com

## 📜 License

This project is licensed under the MIT License. See the LICENSE file for details.

---

> **Note:** This top-level README is intentionally high-level; consult each component's documentation for full details.
