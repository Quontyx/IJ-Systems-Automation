#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
ENV_FILE="$PROJECT_DIR/docker/.env"
BACKUP_DIR="$PROJECT_DIR/backups"

if [ ! -f "$ENV_FILE" ]; then
  echo "No se encuentra el archivo .env"
  exit 1
fi

set -a
source "$ENV_FILE"
set +a

mkdir -p "$BACKUP_DIR"

FECHA=$(date +%F_%H-%M-%S)
SALIDA="$BACKUP_DIR/backup_$FECHA.sql"

docker exec mariadb sh -c "exec mysqldump -u root -p\"$MYSQL_ROOT_PASSWORD\" \"$MYSQL_DATABASE\"" > "$SALIDA"

if [ $? -eq 0 ]; then
  echo "Backup realizado correctamente:"
  echo "$SALIDA"
else
  echo "Error al realizar el backup"
  exit 1
fi
