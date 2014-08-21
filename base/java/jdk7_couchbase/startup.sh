#!/bin/bash

JAR=/home/user/application.jar
EXEC_JAVA=/opt/jdk1.7.0_55/bin/java

untilsuccessful() {
    "$@"
    while [ $? -ne 0 ]
    do
        echo Retrying...
        sleep 1
        "$@"
    done
}

echo "Waiting for Couchbase server initialize..."
service couchbase-server start &>/dev/null

if [ $? -eq 0 ] ; then
    echo "Couchbase server started."

    untilsuccessful /opt/couchbase/bin/couchbase-cli cluster-init -c 127.0.0.1:8091 \
    --cluster-init-username=Administrator \
    --cluster-init-password=password \
    --cluster-init-ramsize=512 &>/dev/null

    echo "Cluster inited with username 'Administrator' and password 'password'."

    untilsuccessful /opt/couchbase/bin/couchbase-cli bucket-create -c 127.0.0.1:8091 \
       --bucket=test_bucket \
       --bucket-type=couchbase \
       --bucket-ramsize=256 \
       --bucket-port=11222 \
       --wait \
       -u Administrator \
       -p password &>/dev/null

    echo "Default bucket created."

    if [ -e $JAR ] ; then
    echo "Starting application."
    $EXEC_JAVA -jar $JAR $ARGUMENTS
    echo "Done."
    else
    echo "Executable jar application dosn't exist."
    fi
else
    echo "Failed to start Couchbase server."
fi

# keep docker container running after stopping of apllication
while true;do true; done
