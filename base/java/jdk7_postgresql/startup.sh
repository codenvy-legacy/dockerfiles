#!/bin/bash

source /home/user/.postgresrc

JAR=/home/user/application.jar
EXEC_JAVA=/opt/jdk1.7.0_55/bin/java

echo "Waiting for PostreSQL server initialize..."
service postgresql start > /dev/null

if [ $? -eq 0 ] ; then
    echo "PostgreSQL server started."

    if [ -e $JAR ] ; then
    echo "Starting application."
    $EXEC_JAVA -jar $JAR $ARGUMENTS
    echo "Done."
    else
    echo "Executable jar application dosn't exist."
    fi
else
    echo "Failed to start PostgreSQL server."
fi
