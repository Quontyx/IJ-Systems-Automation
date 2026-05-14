#!/bin/bash
set -a
source "$(dirname "$0")/../docker/.env"
set +a

BACKUP_DIR="$HOME/IJ-Systems-Automation/backups"

if [ -z "$1" ]; then
    echo "Uso: ./restore.sh nombre_del_backup.sql"
    echo ""
    echo "Backups disponibles:"
    ls -lh "$BACKUP_DIR"/backup_*.sql 2>/dev/null | awk '{print "  " $NF " (" $5 ")" }' || echo "  No hay backups disponibles"
    exit 1
fi

ARCHIVO="$BACKUP_DIR/$1"

if [ ! -f "$ARCHIVO" ]; then
    echo "Error: no existe el archivo: $ARCHIVO"
    echo ""
    echo "Backups disponibles:"
    ls "$BACKUP_DIR"/backup_*.sql 2>/dev/null || echo "  No hay backups disponibles"
    exit 1
fi

echo "Restaurando $1 en ijdb..."
docker exec -i mariadb mariadb -u root -p"$MYSQL_ROOT_PASSWORD" ijdb < "$ARCHIVO"

if [ $? -eq 0 ]; then
    echo "Restauracion completada correctamente"
else
    echo "Error durante la restauracion"
    exit 1
fi
