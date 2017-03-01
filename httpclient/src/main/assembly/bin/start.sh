#userdir
SHDIR=$(cd "$(dirname "$0")"; pwd)
echo current path:$SHDIR

#
PIDFILE="./start.pid"
if [ -f $PIDFILE ]; then
    if kill -0 `cat $PIDFILE` > /dev/null 2>&1; then
        echo server already running as process `cat $PIDFILE`. 
        exit 0
    fi
fi

# exec 
LOGFILE="nohup.out"
nohup java -classpath ../conf/:../lib/* com.jd.testjsf.ServerMain $SHDIR > $LOGFILE &

# wirte pid to file
if [ $? -eq 0 ] 
then
    if /bin/echo -n $! > "$PIDFILE"
    then
        sleep 1
        echo STARTED SUCCESS
    else
        echo FAILED TO WRITE PID
        exit 1
    fi
    tail -100f $LOGFILE
else
    echo SERVER DID NOT START
    exit 1
fi
