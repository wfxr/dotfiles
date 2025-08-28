#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <PID>"
    exit 1
fi

PID=$1

if [ ! -d /proc/$PID ]; then
    echo "Process $PID does not exist."
    exit 1
fi

CLK_TCK=$(getconf CLK_TCK)

function get_cpu_times() {
    if [ ! -r /proc/$PID/stat ]; then
        echo "0 0"
        return
    fi
    STAT=($(cat /proc/$PID/stat))
    UTIME=${STAT[13]}
    STIME=${STAT[14]}
    echo "$UTIME $STIME"
}

read UTIME1 STIME1 < <(get_cpu_times)
START_TIME=$(date +%s)

sleep 30

read UTIME2 STIME2 < <(get_cpu_times)
END_TIME=$(date +%s)

DELTA_UTIME=$((UTIME2 - UTIME1))
DELTA_STIME=$((STIME2 - STIME1))
DELTA_TOTAL=$((DELTA_UTIME + DELTA_STIME))
DURATION=$((END_TIME - START_TIME))

USER_SECONDS=$(echo "scale=2; $DELTA_UTIME/$CLK_TCK" | bc)
SYS_SECONDS=$(echo "scale=2; $DELTA_STIME/$CLK_TCK" | bc)
TOTAL_SECONDS=$(echo "scale=2; $DELTA_TOTAL/$CLK_TCK" | bc)

echo "PID: $PID"
echo "Duration: $DURATION seconds"
echo "User CPU Time:   $USER_SECONDS seconds"
echo "System CPU Time: $SYS_SECONDS seconds"
echo "Total CPU Time:  $TOTAL_SECONDS seconds"
