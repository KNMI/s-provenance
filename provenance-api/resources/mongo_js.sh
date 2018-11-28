#!/bin/bash
echo 'Running ensure_indexes.js'
mongo $SPROV_DB_HOST:$SPROV_DB_PORT/$SPROV_DB /provenance-api/resources/ensure_indexes.js
echo 'Finished with ensure_indexes.js'

echo 'Running lineage_map_reduce.js'
mongo $SPROV_DB_HOST:$SPROV_DB_PORT/$SPROV_DB /provenance-api/resources/lineage_map_reduce.js
echo 'Finished with lineage_map_reduce.js'