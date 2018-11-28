#!/bin/bash

# Update the mongo indices and run it.
bash /provenance-api/resources/mongo_js.sh

# Run the flask service.
export RAAS_LOGGING="True"
export RAAS_REPO="mongodb://$SPROV_DB_HOST/$SPROV_DB"

gunicorn -w 9 -b 0.0.0.0:8082 'flask_raas:bootstrap_app()' --log-level debug --backlog 0 --timeout 120 --error-logfile error.log --log-file access.log