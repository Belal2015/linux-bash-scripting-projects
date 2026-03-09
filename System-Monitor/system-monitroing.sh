#!/bin/bash

# System monitoring script
# This script checks CPU, Memory, and Disk usage
# and prints a message if usage exceeds defined thresholds.


# Variables
CPU_THRESHOLD=80        # Alert if CPU usage exceeds 80%
MEMORY_THRESHOLD=80     # Alert if Memory usage exceeds 80%
DISK_THRESHOLD=80       # Alert if Disk usage exceeds 80%


# Function to monitor CPU usage
check_cpu_usage() 
{
    # Get current CPU usage using top command
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

    # Compare CPU usage with threshold
    if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) ))
    then
        echo "CPU usage is high: $CPU_USAGE%"
    else
        echo "CPU usage is normal: $CPU_USAGE%"
    fi
}


# Function to monitor Memory usage
check_memory_usage() 
{
    # Calculate memory usage percentage
    MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

    # Compare memory usage with threshold
    if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) ))
    then
        echo "Memory usage is high: $MEMORY_USAGE%"
    else
        echo "Memory usage is normal: $MEMORY_USAGE%"
    fi
}


# Function to monitor Disk usage
check_disk_usage() 
{
    # Get disk usage percentage for root partition
    DISK_USAGE=$(df -h / | grep / | awk '{print $5}' | sed 's/%//g')

    # Compare disk usage with threshold
    if (( DISK_USAGE > DISK_THRESHOLD ))
    then
        echo "Disk usage is high: $DISK_USAGE%"
    else
        echo "Disk usage is normal: $DISK_USAGE%"
    fi
}


# Run the monitoring functions
check_cpu_usage
check_memory_usage
check_disk_usage