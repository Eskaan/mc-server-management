#! /bin/bash

echo "Starting Server check"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
touch $SCRIPT_DIR/data/pid
touch $SCRIPT_DIR/data/start
PID=$(cat $SCRIPT_DIR/data/pid)
START=$(cat $SCRIPT_DIR/data/start)
echo "PID=$PID"
echo "START=$START"
if [[ $PID -ne "" ]]; then
	if [[ $PID -eq "lock" ]]; then
		echo "pid is \"lock\", not doing anything."
		exit 0
	fi
	if ls /proc/$pid >> /dev/null; then
		echo "Process running on $pid"
		if [[ $(ps --pid $PID -o lstart)= -eq $START ]]; then
			echo "Process start time matches saved starting time."
			echo "Server still running"
			exit 0
		else
			echo "Process start time does not match saved start time."
			echo "Server was shut down unplanned at unkown time."
			echo "Server no longer running. Restarting Server..."
			$SCRIPT_DIR/start.sh
			exit 1
		fi
	fi
else
	echo "Server shutdown saved."
	$SCRIPT_DIR/start.sh
fi
