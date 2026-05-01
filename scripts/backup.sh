#!/bin/bash
set -a
source "$(dirname "$0")/../docker/.env"
set +a
BACKUP_DIR="$HOME/IJ-Systems-Automation/backups"
FECHA=$(date +%F_%H-%M-%S)
ARCHIVO="$BACKUP_DIR/backup_$FECHA.sql"

mkdir -p "$BACKUP_DIR"

docker exec mariadb mariadb-dump -u root -p"$MYSQL_ROOT_PASSWORD" ijdb > "$ARCHIVO"

if [ $? -eq 0 ]; then
    echo "Backup realizado correctamente: $ARCHIVO"
else
    echo "Error al realizar el backup"
fi
