#!/bin/bash

source ./PosixSyncFS.ini

# Check if the device mapper mapping already exists
if dmsetup ls | grep -q "^$mapping_name"; then
    echo "Device mapper mapping $mapping_name already exists."
	dmsetup remove $mapping_name
fi

# Get list of loop devices and sort them
devices=$(losetup -nO NAME | sort -t / -k 3V)

if [ -z "$devices" ]; then
	echo "No loopback devices available to map, exit"
	exit 1
fi

# Calculate the total size of all loop devices
total_blocks=0
for device in $devices; do
    blocks=$(blockdev --getsz "$device")
    total_blocks=$((total_blocks + blocks))
done

# Create the mapping table for all loop devices
mapping_table=""
start_block=0
for device in $devices; do
    blocks=$(blockdev --getsz "$device")
    mapping_table+="$start_block $blocks linear $device 0\n"
    start_block=$((start_block + blocks))
done

# Create the device mapper mapping
echo -e "$mapping_table" | dmsetup create $mapping_name
