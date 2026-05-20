#!/bin/bash
set -e

echo "=== Starting Fuseki Setup ==="

FUSEKI_HOME=/fuseki
DATA_DIR=/staging
DB_DIR=$FUSEKI_HOME/databases/dataset_hadits

# Buat folder database jika belum ada
mkdir -p $DB_DIR

# Load data TTL ke TDB2 jika database masih kosong
if [ -z "$(ls -A $DB_DIR)" ]; then
    echo "=== Loading RDF data into TDB2 ==="
    
    # Load semua file TTL dari /staging
    for f in $DATA_DIR/*.ttl; do
        if [ -f "$f" ]; then
            echo "Loading: $f"
            /jena/bin/tdb2.tdbloader --loc=$DB_DIR "$f"
        fi
    done
    
    echo "=== Data loading complete ==="
else
    echo "=== Database already exists, skipping data load ==="
fi

echo "=== Starting Fuseki Server ==="

# Start Fuseki
exec /docker-entrypoint.sh /fuseki/fuseki-server \
    --config=/fuseki/configuration/dataset_hadits.ttl \
    --port=3030
