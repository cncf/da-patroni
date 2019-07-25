# dapatroni

Patroni deployment on AWS+OpenEBS+local-storage-nfs


# TODO

- TODO: we can probably replace backups on LF (NFSwith RWX) into (local-storage RWO).
- Backups will require new docker container that will list all instance DBs and dump them.
