#!/bin/bash

# Network configuration script
# This script configures a static IP address for a network interface
# using nmcli, restarts the connection, and displays the configuration.


# Variables

INTERFACE="enp0s2"          # Network interface name
STATIC_IP="192.168.64.5"    # Static IP address
CIDR=24                     # Network subnet mask
GATEWAY="192.168.64.1"      # Default gateway
DNS1="8.8.8.8"              # DNS server



# Function to set a static IP

configure_static_ip()
{
echo "Configuring static IP..."

# Create a new network connection
sudo nmcli con add type ethernet autoconnect yes con-name $INTERFACE ifname $INTERFACE

# Set the static IP address
sudo nmcli con mod "$INTERFACE" ipv4.addresses "$STATIC_IP/$CIDR"

# Set the gateway
sudo nmcli con mod "$INTERFACE" ipv4.gateway $GATEWAY

# Set DNS server
sudo nmcli con mod "$INTERFACE" ipv4.dns $DNS1

# Set IPv4 method to manual (static)
sudo nmcli con mod "$INTERFACE" ipv4.method manual

echo "Static IP configuration done."
}


# Function to restart the network connection

restart_network() 
{
echo "Restarting network service..."

# Bring the network connection up
sudo nmcli con up "$INTERFACE"

echo "Network service restarted."
}


# Function to display current network configuration

show_network_config()
 {
echo "Current network configuration:"

# Show IP address for the interface
ip addr show "$INTERFACE"
}


# Function to automate the whole network configuration

automate_network_config()
{
configure_static_ip
restart_network
show_network_config
}


# Execute the automation function

automate_network_config