#!/bin/bash
if  [ -z "$1" ]
then
  echo "$0: you need to specify env: test, dev, stg, prod"
  exit 1
fi
change_namespace.sh $1 devstats
"${1}h.sh" delete patroni-backup
"${1}h.sh" delete patroni
"${1}h.sh" delete patroni-secret
"${1}k.sh" delete pvc pgdata-devstats-postgres-0 pgdata-devstats-postgres-1 pgdata-devstats-postgres-2
change_namespace.sh $1 default
