#!/bin/bash
set -eo pipefail
set -x
shopt -s nullglob
echo "ssl: $DB_SSL"
if [ $DB_SSL = fasle ]
then
  echo "ssl is disabled"
  mysql $DB_NAME -h$DB_HOST -u$DB_USER -p$DB_PASSWORD < /mnt/schema.sql
else
  echo "ssl is enabled"
  mysql $DB_NAME -h$DB_HOST -u$DB_USER -p$DB_PASSWORD --ssl < /mnt/schema.sql
fi