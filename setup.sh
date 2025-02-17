#!/bin/bash
if  [ -z "$1" ]
then
  echo "$0: you need to specify env: test, dev, stg, prod"
  exit 1
fi
"${1}h.sh" install devstats-namespace ./da-patroni --set "deployEnv=$1,skipSecret=1,skipBackupsPV=1,skipBackups=1,skipPostgres=1"
change_namespace.sh $1 devstats
##"${1}h.sh" install --dry-run --debug --generate-name ./da-patroni --set skipSecret=1,skipBackupsPV=1,skipBackups=1,skipNamespace=1
"${1}h.sh" install patroni-secret ./da-patroni --set "deployEnv=$1,skipBackupsPV=1,skipBackups=1,skipPostgres=1,skipNamespace=1"
"${1}h.sh" install patroni ./da-patroni --set "deployEnv=$1,skipSecret=1,skipBackupsPV=1,skipBackups=1,skipNamespace=1"
"${1}h.sh" install patroni-backup ./da-patroni --set "deployEnv=$1,skipSecret=1,skipNamespace=1,skipPostgres=1"
change_namespace.sh $1 default
