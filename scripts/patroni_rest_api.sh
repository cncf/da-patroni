#!/bin/bash
# Login to any patroni node devstats-patroni-N: ./devstats-k8s-lf/util/pod_shell.sh devstats-postgres-N
curl -s localhost:8008/config | jq .
# \watch 2
patronictl list
patronictl show-config
patronictl restart devstats-postgres
patronictl query --password -d devstats -c 'select dt, proj, prog, msg from gha_logs order by dt desc limit 50'
# Final one
curl -s -XPATCH -d '{"loop_wait": "15", "postgresql": {"parameters": {"shared_buffers": "96GB", "max_parallel_workers_per_gather": "12", "max_connections": "1024", "max_wal_size": "16GB", "effective_cache_size": "192GB", "maintenance_work_mem": "2GB", "checkpoint_completion_target": "0.9", "wal_buffers": "128MB", "max_wal_size": "8GB", "max_worker_processes": "56", "max_parallel_workers": "56", "temp_file_limit": "50GB", "hot_standby": "on", "wal_log_hints": "on", "wal_keep_segments": "10", "wal_level": "hot_standby", "max_wal_senders": "5", "max_replication_slots": "5"}, "use_pg_rewind": true}}' http://localhost:8008/config | jq .
