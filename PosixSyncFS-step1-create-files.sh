#!/bin/bash

source ./PosixSyncFS.ini

for num in $(seq -w 1 $file_number); do
	file="$file_prefix-$num"
	truncate -s 10M "$file" &
done

wait
