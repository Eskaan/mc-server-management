#! /bin/bash

echo "Starting Server check"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#Create files if not existing and load them in
SESSION=$(cat $SCRIPT_DIR/data/session 2> /dev/null)

if [[ "$SESSION" != "" ]]; then
	if [[ "$SESSION" == "lock" ]]; then
		echo "Session is \"lock\", not doing anything."
		exit 0
	elif [[ $(tmux list-sessions | grep "$SESSION" | wc -l) -eq 1 ]]; then
		echo "Session still running."
		echo "> $SESSION"
		echo "Doing nothing."
		exit 0
	else
		echo "Session does not match saved session."
		echo "Server was shut down unplanned."
		echo "Server no longer running. Restarting Server..."
		$SCRIPT_DIR/start.sh
		exit 1
	fi
else
	echo "Server shutdown saved. Restarting..."
	$SCRIPT_DIR/start.sh
fi
