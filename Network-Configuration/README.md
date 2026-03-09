# Network Configuration Helper

A simple Bash script that uses NetworkManager's `nmcli` to
configure a **static IP address** on a specified Ethernet interface,
restart the connection, and display the resulting configuration.

This repository is designed for quick network setup on Linux
systems where NetworkManager is available. The single script
`network-config.sh` can be run manually or incorporated into other
automation.

---

## Features ✅

* Configure a static IPv4 address, gateway, and DNS using `nmcli`.
* Restart the connection to apply changes.
* Display the current interface configuration.
* Easily customize interface name, IP, subnet and other parameters.
* Suitable for provisioning VMs, containers, or bare-metal nodes.
* Can be extended for DHCP toggling or multiple interfaces.

---

## Requirements 🔧

* A Linux system with **NetworkManager** installed.
* `bash` shell.
* `nmcli` command-line utility.
* Root privileges (the script uses `sudo` for modifying connections).
* Common networking tools (`ip`) for displaying configuration.

No external dependencies beyond standard utilities.

---

## Configuration 🛠

Edit the variables at the top of `network-config.sh` to match your
environment:

```bash
INTERFACE="enp0s2"          # Network interface name (e.g. eth0)
STATIC_IP="192.168.64.5"    # Static IP address
CIDR=24                     # Prefix length (e.g. 24 for 255.255.255.0)
GATEWAY="192.168.64.1"      # Default gateway
DNS1="8.8.8.8"              # Primary DNS server
```

Alternatively, export them in the environment before running the script:

```bash
export INTERFACE=eth0
export STATIC_IP=10.0.0.10
./network-config.sh
```

The script will respect exported values or fall back to the hard‑coded defaults.

---

## Usage ▶️

Make the script executable and execute it:

```bash
chmod +x network-config.sh
./network-config.sh
```

Sample output:

```
Configuring static IP...
Static IP configuration done.
Restarting network service...
Network service restarted.
Current network configuration:
2: enp0s2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 ...
    inet 192.168.64.5/24 brd 192.168.64.255 scope global dynamic enp0s2
    ...
```

The script automatically runs the full workflow: configure, restart,
and then show the results.

---

## Automation & Scheduling 🕒

This script can be run as part of an initialization or provisioning
step. For example, call it from a cloud-init user‑data script, Ansible
playbook, or a bootstrap shell. You may also wrap it in a larger
framework to configure multiple machines.

Since NetworkManager persists connections, the static IP will survive
reboots once created.

---

## Customization & Extending ✨

* To support additional DNS servers or search domains, modify the
  `nmcli con mod` commands in `configure_static_ip()`.
* Add command‑line options for interface, IP, etc. using `getopts`.
* Add DHCP support by toggling `ipv4.method auto` versus manual.
* Add IPv6 configuration or multiple interface handling.

Feel free to fork and enhance the script for your particular use case.

---

## Troubleshooting 🛠

* **"Connection already exists" errors?** Delete any existing connection
  with `nmcli con delete <name>` before rerunning or choose a unique
  `con-name`.
* **Changes not applied?** Ensure the interface name matches `ip link`
  output and that NetworkManager is managing it.
* **Permission denied?** Run the script as root or with a user that can
  run `sudo nmcli` without a password, if desired.
* **`nmcli` not found?** Install NetworkManager (`sudo apt install
  network-manager` or equivalent).

---

## Contributing

Improvements, bug fixes, and documentation updates are welcome.
Open an issue or submit a pull request with your changes.

---

## License 📄

This project is licensed under the MIT License. See the
[LICENSE](LICENSE) file for details.

EOF