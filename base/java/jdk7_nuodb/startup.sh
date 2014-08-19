#!/bin/bash

JAR=/home/user/application.jar
EXEC_JAVA=/opt/jdk1.7.0_55/bin/java

ln -s /opt/jdk1.7.0_55/bin/java /usr/bin/java

service nuoagent start &>/dev/null

if [ $? -eq 0 ] ; then
    echo "NuoDB server started."

    /opt/nuodb/bin/nuodbmgr --broker localhost --user domain --password bird --command "start process sm host localhost database testDB archive /opt/nuodb/samples/testData initialize true" &>/dev/null
    /opt/nuodb/bin/nuodbmgr --broker localhost --user domain --password bird --command "start process te host localhost database testDB options '--dba-user dba --dba-password bird'" &>/dev/null

    if [ -e $JAR ] ; then
    echo "Starting application."
    $EXEC_JAVA -jar $JAR $ARGUMENTS
    echo "Done."
    else
    echo "Executable jar application dosn't exist."
    fi
else
    echo "Failed to start NuoDB server."
fi

# keep docker container running after stopping of apllication
while true;do true; done
