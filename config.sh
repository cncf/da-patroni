#!/bin/bash
if  [ -z "$1" ]
then
  echo "$0: you need to specify env: test, dev, stg, prod"
  exit 1
fi
"${1}k.sh" exec -it devstats-postgres-0 -n devstats -- /usr/bin/curl -s -XPATCH -d '{"loop_wait": "15", "postgresql": {"parameters": {"shared_buffers": "16GB", "max_parallel_workers_per_gather": "3", "max_ache_size": "32GB", "maintenance_work_mem": "512MB", "checkpoint_completion_target": "0.9", "wal_buffers": "128MB", "max_wal_size": "4GB", "max_worker_processes": "6", "max_parallel_workers": "6", "temp_file_limit": "32GB", "hot_standby": "on", "wal_log_hints": "on", "wal_keep_segments": "10", "wal_level": "hot_standby", "max_wal_senders": "5", "max_replication_slots": "5"}, "use_pg_rewind": true}}' http://localhost:8008/config
"${1}k.sh" exec -it devstats-postgres-0 -n devstats -- /usr/local/bin/patronictl restart devstats-postgres --force
"${1}k.sh" exec -it devstats-postgres-0 -n devstats -- /usr/local/bin/patronictl show-config
