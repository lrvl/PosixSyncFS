#!/bin/bash
source ./PosixSyncFS.ini
rclone -v sync local:/root/losetup/devicefiles "${sync_destination}"
