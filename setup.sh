#!/bin/bash
if  [ -z "$1" ]
then
  echo "$0: you need to specify env: test, dev, stg, prod"
  exit 1
fi
change_namespace.sh $1 devstats
"${1}h.sh" install patroni-secret ./da-patroni --set skipBackupsPV=1,skipBackups=1,skipPostgres=1,skipNamespace=1
change_namespace.sh $1 default