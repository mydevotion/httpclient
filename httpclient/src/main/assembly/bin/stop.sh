PIDFILE="./start$1.pid"
echo $PIDFILE
if [ ! -f "$PIDFILE" ]
then
    echo "no zookeeper to stop (could not find file $PIDFILE)"
else
    kill -9 $(cat "$PIDFILE")
    rm -f "$PIDFILE"
    echo STOPPED
fi
exit 0
