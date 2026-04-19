#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
ENV_FILE="$PROJECT_DIR/docker/.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "No se encuentra el archivo .env"
  exit 1
fi

if [ -z "$1" ]; then
  echo "Uso: ./restore.sh nombre_del_backup.sql"
  exit 1
fi

BACKUP_FILE="$PROJECT_DIR/backups/$1"

if [ ! -f "$BACKUP_FILE" ]; then
  echo "No existe el backup: $BACKUP_FILE"
  exit 1
fi

set -a
source "$ENV_FILE"
set +a

docker exec -i mariadb sh -c "exec mysql -u root -p\"$MYSQL_ROOT_PASSWORD\" \"$MYSQL_DATABASE\"" < "$BACKUP_FILE"

if [ $? -eq 0 ]; then
  echo "Restauración completada correctamente."
else
  echo "Error durante la restauración."
  exit 1
fi
