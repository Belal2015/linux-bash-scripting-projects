# Log Rotation Utility

A small Bash script that automatically **rotates log files** when they grow too large and **removes old compressed archives**.

Suitable for applications producing `.log` files in a directory; works as a standalone tool or from cron.

---

## Features ✅

* Rotate any `*.log` file in a given directory once it exceeds a configurable size.
* Compress rotated files with `gzip` and timestamp them.
* Prune old `.gz` archives based on age (days).
* Environment-variable overrides make it easy to adapt per‑host or per‑deployment.
* Safe defaults and error checks prevent accidental data loss.

---

## Configuration 🔧

| Variable        | Default        | Description |
|----------------|----------------|-------------|
| `LOG_DIR`      | `/var/log/myapp` | Directory containing plain-text log files to rotate. Must exist. |
| `MAX_LOG_SIZE` | `10485760`     | Size threshold in bytes (10 MiB by default). Logs larger than this are rotated. |
| `MAX_LOG_AGE`  | `30`           | Number of days after which compressed archives (`*.gz`) are deleted. |

You can set variables either by exporting them in the environment or by prefixing the script invocation, e.g.

```bash
LOG_DIR=/var/log/otherapp MAX_LOG_SIZE=5000000 ./rotate-logs.sh
```

---

## Installation 📁

1. Clone or copy the repository/content to your server:

   ```bash
   git clone https://example.com/rotate-logs.git
   cd rotate-logs
   ```

2. Make the script executable:

   ```bash
   chmod +x rotate-logs.sh
   ```

3. Adjust configuration variables directly in the file or via environment, as shown above.

---

## Usage ▶️

Run the script manually to perform a one‑off rotation and cleanup:

```bash
./rotate-logs.sh
```

If `LOG_DIR` does not exist the script will exit with an error. Only files ending in `.log` are considered; if none are present the script does nothing.

Example output:

```
Rotated: /var/log/myapp/server.log
Deleted archives older than 30 days.
```

---

## Scheduling with Cron 🕒

To rotate logs regularly, add a cron entry. Edit the crontab for the desired user (`crontab -e`) and include:

```cron
# rotate every night at 2 AM
0 2 * * * /path/to/rotate-logs.sh
```

You can export environment variables in the cron file or wrap the call in a small shell script that sets them.

---

## Troubleshooting & Tips 🛠

* **No rotation happening?** Check that files actually exceed `MAX_LOG_SIZE` and that they end in `.log`.
* **Permission issues:** Ensure the executing user has write access to `LOG_DIR` and its contents.
* **Custom compression:** The script uses `gzip`; you may change it or add `bzip2`/`xz` as desired.
* **Preserving disk usage:** If you need more advanced retention (keep N files, combine with `logrotate`, etc.), use this tool as a simple pre‑processor.

---

## Extending the Script ✨

Feel free to modify or wrap the functions: for example, add an argument to only rotate a single file, or integrate with systemd timers.

Contributions and improvements are welcome; open an issue or pull request with your changes.

---

## License 📄

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.