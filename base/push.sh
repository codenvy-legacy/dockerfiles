#
# This script pushes all the docker files
#

function check_status {
  if [ "$?" != "0" ]; then
    exit $?
  fi
}

dockerfiles=$(find . -type d ! -path . -printf "%f\n")

echo "Building ${#dockerfiles[*]} dockerfiles..."

for dockerfile in ${dockerfiles[*]}
do
  cd $dockerfile; check_status
  pwd
  docker push codenvy/$dockerfile; check_status
  cd ..; check_status
done

echo "Everything's Ok!"

