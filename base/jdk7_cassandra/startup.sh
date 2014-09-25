#!/bin/bash

CASSANDRA_LOG=/home/user/cassandra.log
JAR=/home/user/application.jar
EXEC_JAVA=/opt/jdk1.7.0_55/bin/java

JAVA_HOME=/opt/jdk1.7.0_55
PATH=/opt/jdk1.7.0_55/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

function wait_cassandra_ready_to_connect {
    # Elxecute cassandra service
    start-stop-daemon -S -c cassandra -a /usr/sbin/cassandra -p /var/run/cassandra/cassandra.pid > $CASSANDRA_LOG
#    tail -f $CASSANDRA_LOG
    # Wait until cassandra logs that it's ready (or timeout after 60s)
    COUNTER=0
    echo "Waiting for Cassandra initialize..."
    grep -qs 'state jump to normal' $CASSANDRA_LOG

    while [[ $? -ne 0 && $COUNTER -lt 60 ]] ; do
        sleep 2
        let COUNTER+=2
    grep -q 'state jump to normal' $CASSANDRA_LOG
    done

    if [ $? -eq 0 ] ; then
    execute_user_jar
    else
    echo "Failed to start Cassandra. Timeout limit exceeded."
    show_cassandra_logs
    fi
}

function execute_user_jar {
    if [ -e $JAR ] ; then
    echo "Starting application."
        $EXEC_JAVA -jar $JAR $ARGUMENTS
    echo "Done."
    else
        echo "Executable jar application doesn't exist."
    fi
}

function show_cassandra_logs {
    if [ -e $CASSANDRA_LOG ] ; then
        echo "Cassandra logs:"
        cat $CASSANDRA_LOG
    fi
}

wait_cassandra_ready_to_connect

# keep docker container running after stopping of apllication
while true;do true; done
