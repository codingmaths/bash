#!/bin/bash
## File : disable_oom
## Author : Sanjay <sanjaym756@@gmail.com>

pid_file=${1?}

function log() {
    local msg=$*
    date_timestamp=$(date +['%Y-%m-%d %H:%M:%S'])
    echo -ne "$date_timestamp $msg\n"
    
    if [ -n "$LOG_FILE" ]; then
        echo -ne "$date_timestamp $msg\n" >> "$LOG_FILE"
    fi
}

if [ ! -f "$pid_file" ]; then
    log "Error $pid_file doesn't exist"
    exit 1
fi

pid=$(cat "$pid_file")
if [ ! -d "/proc/$pid" ]; then
    log "Warning: process($pid) is not alive"
    exit 0
fi

log "disable oom for $pid"
echo -17 > "/proc/$pid/oom_score_adj"
