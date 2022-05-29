#! /bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/server.conf
cd $SERVER_DIR

# Start Server and get SESSION
SESSIONID=\
$(tmux new-session -dPF "#S" -c "$SERVER_DIR" \
"$JAVA $JAVA_ARGS -jar $SERVER_LAUNCH_JAR $SERVER_ARGS;rm $SCRIPT_DIR/data/session"\
)
echo "Server started. Saving session."
echo $SESSIONID > $SCRIPT_DIR/data/sid
tmux list-sessions | grep "$SESSIONID: " > $SCRIPT_DIR/data/session
