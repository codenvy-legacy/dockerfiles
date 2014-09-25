#
# This script builds and pushes all the docker files
#

function check_status {
  if [ "$?" != "0" ]; then
    exit $?
  fi
}

dockerfiles=(
  "shellinabox"
  "jdk7"
  "jdk7_cassandra"
  "jdk7_vnc"
  "jdk7_cli"
  "jdk7_couchbase"
  "jdk7_exo"
  "jdk7_glassfish4"
  "jdk7_jboss7"
  "jdk7_jetty9"
  "jdk7_mongodb"
  "jdk7_mysql"
  "jdk7_neo4j"
  "jdk7_nuodb"
  "jdk7_play1"
  "jdk7_postgresql"
  "jdk7_riak"
  "jdk7_tomcat7"
  "jdk7_tomee"
  "android"
  "angular-yeoman"
  "angular-gulp"
  "cpp"
  "cpp_qt4"
  "php56_apache2"
  "python27"
  "python34"
  "ruby210"
  "ruby210_rails403"
)

echo "Building ${#dockerfiles[*]} dockerfiles..."

for dockerfile in ${dockerfiles[*]}
do
#  echo "dockerfile: codenvy/"$dockerfile
  cd $dockerfile; check_status
  pwd
  sudo docker build -t codenvy/$dockerfile .; check_status
  sudo docker push codenvy/$dockerfile; check_status
  cd ..; check_status
done

echo "Everything's Ok!"

