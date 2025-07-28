#!/usr/bin/env bash

# Usage: ./run.sh dump|load [additional sqldatadump args]
# Requires environment variables:
#   CONN - for both sqldatadump and sqldataload

set -e

mkdir -p /data/table_data

if [[ "$1" == "dump" ]]; then
  shift
  sqldatadump --directory=/data/table_data \
              --schema=CORE \
              --rowsPerBatch=1000 \
              --batchesPerFile=10 \
              --ignoreTables=CarrierRef,MasterLocation,Instance \
              "$CONN" "$@"
elif [[ "$1" == "load" ]]; then
  sqldataload --directory=/data/table_data "$CONN"
else
  echo "Usage: $0 dump|load [additional sqldatadump args]"
  exit 1
fi
