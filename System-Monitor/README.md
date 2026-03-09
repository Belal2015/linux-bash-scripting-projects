# System Monitor Script

A lightweight Bash utility that **checks local CPU, memory, and disk usage** against configurable thresholds. It prints warnings when any resource is considered "high" and can be run manually or scheduled via cron to provide simple system monitoring on Linux servers.

This repository contains a single script (`system-monitroing.sh`) and is ideal for small environments where you want quick visibility without installing complex tools.

---

## Features ✅

* Monitor **CPU**, **memory**, and **disk** utilization.
* Compare usage against threshold variables defined at the top of the script.
* Output helpful messages indicating normal or high usage for each resource.
* Easy to modify—just edit thresholds or add new checks.
* Scheduling-friendly: run from cron, systemd timers, or other orchestration.

---

## Requirements 🔧

* A Unix-like OS (Linux, macOS with minor adjustments).
* `bash` (POSIX shell may work with tweaks).
* Standard utilities: `top`, `awk`, `free`, `df`, `bc`.

No additional packages are needed, but `bc` is used for floating-point comparisons.

---

## Configuration 🛠

Below the shebang in `system-monitroing.sh` you will find three variables with default thresholds:

```bash
CPU_THRESHOLD=80      # percent
MEMORY_THRESHOLD=80   # percent
DISK_THRESHOLD=80     # percent (for the root filesystem `/`)
```

Change these values directly in the script or, if you prefer, export them in the environment before running:

```bash
export CPU_THRESHOLD=90
export MEMORY_THRESHOLD=75
./system-monitroing.sh
```

The script reads the variables from the environment if they are set; otherwise it falls back to the hard‑coded defaults.

---

## Usage ▶️

Make the script executable and run it manually:

```bash
chmod +x system-monitroing.sh
./system-monitroing.sh
```

Example output:

```
CPU usage is normal: 12.4%
Memory usage is high: 82.1%
Disk usage is normal: 47%
```

The script exits with status `0` regardless of the results, so you may want to wrap it in a wrapper that checks for warnings if you’re using it in automation.

---

## Scheduling with Cron 🕒

To perform regular monitoring, add an entry to your crontab (`crontab -e`):

```cron
# run every 5 minutes
*/5 * * * * /path/to/system-monitroing.sh >> /var/log/system-monitor.log 2>&1
```

Redirect output to a log file or use a notification mechanism as needed. You can also set thresholds via environment variables inside the cron file or via a small wrapper script.

---

## Troubleshooting & Tips 🛠

* **Script errors?** Ensure `top`, `awk`, `free`, `df`, and `bc` are installed and available in `PATH`.
* **Disk check always 0?** The script currently checks `/` only. Modify the `df` command in `check_disk_usage()` to inspect other mounts.
* **Floating‑point precision:** `bc` performs the comparison; adjust `scale` or logic if necessary.
* **Customization:** You can extend the script with additional checks (network, temperature, etc.) or convert it to a more robust monitoring solution.

---

## Contributing ✨

Feel free to fork the repository, add new features, documentation, or fixes, and open a pull request. Simple enhancements such as parameterizing paths, adding CLI arguments, or supporting multiple mount points are welcome.

If you spot a bug, please open an issue with reproduction steps.

---

## License 📄

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.