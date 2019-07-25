#!/bin/bash
if  [ -z "$1" ]
then
  echo "$0: you need to specify env: test, dev, stg, prod"
  exit 1
fi
change_namespace.sh $1 devstats
"${1}h.sh" delete patroni
"${1}h.sh" delete patroni-secret
change_namespace.sh $1 default
