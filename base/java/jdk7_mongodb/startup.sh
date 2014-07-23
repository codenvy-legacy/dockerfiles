#!/bin/bash

MONGO_LOG=/home/user/mongodb.log
JAR=/home/user/application.jar
EXEC_JAVA=/opt/jdk1.7.0_55/bin/java

function wait_mongodb_ready_to_connect {
    # Execute mongod service
    mkdir -p /opt/mongodb/db
    /usr/bin/mongod --dbpath /opt/mongodb/db --port 27017 --smallfiles --httpinterface --rest --fork --logpath $MONGO_LOG > /dev/null

    # Wait until mongo logs that it's ready (or timeout after 60s)
    COUNTER=0
    echo "Waiting for MongoDB initialize..."
    grep -qs 'waiting for connections on port' $MONGO_LOG

    while [[ $? -ne 0 && $COUNTER -lt 60 ]] ; do
        sleep 2
        let COUNTER+=2
	grep -q 'waiting for connections on port' $MONGO_LOG
    done

    if [ $? -eq 0 ] ; then
	execute_user_jar
    else
	echo "Failed to start MongoDB. Timeout limit exceeded."
	show_mongodb_logs
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

function show_mongodb_logs {
    if [ -e $MONGO_LOG ] ; then
        echo "MongoDB logs:"
        cat $MONGO_LOG
    fi
}

wait_mongodb_ready_to_connect