#!/bin/bash

source /home/user/.mysqlrc

JAR=/home/user/application.jar
EXEC_JAVA=/opt/jdk1.7.0_55/bin/java

echo "Waiting for MySQL server initialize..."
service mysql start > /dev/null

if [ $? -eq 0 ] ; then
    echo "MySQL server started."

    if [ -e $JAR ] ; then
        echo "Starting application."
        $EXEC_JAVA -jar $JAR $ARGUMENTS
        echo "Done."
    else
        echo "Executable jar application dosn't exist."
    fi
else
    echo "Failed to start MySQL server."
fi

# keep docker container running after stopping of apllication
sleep 365d
