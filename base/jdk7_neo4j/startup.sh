#!/bin/bash

JAR=/home/user/application.jar
EXEC_JAVA=/opt/jdk1.7.0_55/bin/java

ulimit -n 4096

echo "Waiting for Neo4j server initialize..."
ulimit -n 4096
service neo4j-service start &>/dev/null

if [ $? -eq 0 ] ; then
    echo "Neo4j server started."

    if [ -e $JAR ] ; then
    echo "Starting application."
    $EXEC_JAVA -jar $JAR $ARGUMENTS
    echo "Done."
    else
    echo "Executable jar application dosn't exist."
    fi
else
    echo "Failed to start Neo4j server."
fi

# keep docker container running after stopping of apllication
sleep 365d

