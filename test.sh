#!/bin/bash
if  [ -z "$1" ]
then
  echo "$0: you need to specify env: test, dev, stg, prod"
  exit 1
fi
k="${1}k.sh"
function finish {
  "$k" delete pod patroni-test
}
trap finish EXIT
"${1}k.sh" run --generator=run-pod/v1 --image=psql patroni-test --env="PG_HOST=`cat da-patroni/secrets/PG_HOST.secret`" --env="PG_USER=`cat da-patroni/secrets/PG_ADMIN_USER.secret`" --env="PGPASSWORD=`cat da-patroni/secrets/PG_PASS.${1}.secret`" -- /bin/sleep 3600s
while [ ! "`${1}k.sh get po | grep patroni-test | awk '{ print $3 }'`" = "Running" ]
do
  echo "Waiting for pod to be running..."
  sleep 1
done
"${1}k.sh" cp test_db.sh patroni-test:/usr/bin/test_db.sh
"${1}k.sh" exec -it patroni-test -- /usr/bin/test_db.sh
