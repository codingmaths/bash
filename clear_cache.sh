#!/bin/bash -e
## Author : Denny <denny@dennyzhang.com>

echo "Free cached memory."

pre_memory=$(free -gl)
echo "$pre_memory" | cat

echo 3 > /proc/sys/vm/drop_caches
sync

pre_memory=$(free -gl)
echo "$pre_memory" | cat
