#!/bin/bash
# Login to any patroni node devstats-patroni-N: ./devstats-k8s-lf/util/pod_shell.sh devstats-postgres-N
curl -s localhost:8008/config | jq .
# \watch 2
patronictl list
patronictl show-config
patronictl restart devstats-postgres
patronictl query --password -d devstats -c 'select dt, proj, prog, msg from gha_logs order by dt desc limit 50'
# Final one
curl -s -XPATCH -d '{"loop_wait": "15", "postgresql": {"parameters": {"shared_buffers": "16GB", "max_parallel_workers_per_gather": "3", "max_connections": "128", "max_wal_size": "16GB", "effective_cache_size": "32GB", "maintenance_work_mem": "512MB", "checkpoint_completion_target": "0.9", "wal_buffers": "128MB", "max_wal_size": "4GB", "max_worker_processes": "6", "max_parallel_workers": "6", "temp_file_limit": "32GB", "hot_standby": "on", "wal_log_hints": "on", "wal_keep_segments": "10", "wal_level": "hot_standby", "max_wal_senders": "5", "max_replication_slots": "5"}, "use_pg_rewind": true}}' http://localhost:8008/config | jq .
