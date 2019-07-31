#!/bin/bash
psql -h$PG_HOST -U$PG_USER postgres -tAc 'select datname from pg_database order by datname'
