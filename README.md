# da-patroni

Patroni deployment on AWS, OpenEBS and local-storage-nfs

Please provide secret values for each file in `./secrets/*.secret.example` saving it as `./secrets/*.secret` or specify them from the command line.
Please note that `vim` automatically adds new line to all text files, to remove it run `truncate -s -1` on a saved file.
List of secrets:
- File `secrets/PG_ADMIN_USER.secret` or --set `pgAdminUser=...` setup postgres admin user name.
- File `secrets/PG_HOST.secret` or --set `pgHost=...` setup postgres host name.
- File `secrets/PG_HOST_RO.secret` or --set `pgHostRO=...` setup postgres host name (read-only).
- File `secrets/PG_PASS.secret` or --set `pgPass=...` setup postgres password for the default user (gha_admin).
- File `secrets/PG_PASS_RO.secret` or --set `pgPassRO=...` setup for the read-only user (ro_user).
- File `secrets/PG_PASS_TEAM.secret` or --set `pgPassTeam=...` setup the team user (also read-only) (devstats_team).
- File `secrets/PG_PASS_REP.secret` or --set `pgPassRep=...` setup the replication user.

You can install only selected templates, see `values.yaml` for detalis (refer to `skipXYZ` variables in comments), example:
- `helm install --dry-run --debug --generate-name ./da-patroni --set skipSecret=1,skipBackupsPV=1,skipBackups=1,skipPostgres=1,skipNamespace=1`.

Please note variables commented out in `./da-patroni/values.yaml`. You can either uncomment them or pass their values via `--set variable=name`.

Resource types used: secret, pv, pvc, po, cronjob, deployment, svc


# TODO

- TODO: we can probably replace backups on LF (NFS with RWX) into (local-storage RWO).
- Backups will require new docker container that will list all instance DBs and dump them.
