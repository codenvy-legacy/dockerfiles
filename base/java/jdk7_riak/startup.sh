#!/bin/bash

JAR=/home/user/application.jar
EXEC_JAVA=/opt/jdk1.7.0_55/bin/java

ulimit -n 4096

untilsuccessful() {
    "$@"
    while [ $? -ne 0 ]
    do
        sleep 1
        "$@"
    done
}

echo "Waiting for Riak server initialize..."
riak start

untilsuccessful riak-admin test &>/dev/null

if [ $? -eq 0 ] ; then
    echo "Riak server started."

    if [ -e $JAR ] ; then
    echo "Starting application."
    $EXEC_JAVA -jar $JAR $ARGUMENTS
    echo "Done."
    else
    echo "Executable jar application dosn't exist."
    fi
else
    echo "Failed to start Riak server."
fi
