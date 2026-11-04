
#!/bin/bash
set -e

echo "Inicializando base de datos para Jira..."

psql \
  --username "$POSTGRES_USER" \
  --dbname "$POSTGRES_DB" \
  -v jira_user="$JIRA_DB_USER" \
  -v jira_password="$JIRA_DB_PASSWORD" \
  -v jira_db="$JIRA_DB_NAME" \
  -v ON_ERROR_STOP=1 <<'EOSQL'

CREATE USER :"jira_user"
WITH PASSWORD :'jira_password';

CREATE DATABASE :"jira_db"
OWNER :"jira_user";

EOSQL

echo "Base de datos de Jira creada correctamente."
