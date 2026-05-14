#!/bin/bash
set -a
source "$(dirname "$0")/../docker/.env"
set +a

BACKUP_DIR="$HOME/IJ-Systems-Automation/backups"
FECHA=$(date +%F_%H-%M-%S)
ARCHIVO="$BACKUP_DIR/backup_$FECHA.sql"
DIAS_RETENCION=7

mkdir -p "$BACKUP_DIR"

echo "Realizando backup de ijdb..."
docker exec mariadb mariadb-dump -u root -p"$MYSQL_ROOT_PASSWORD" ijdb > "$ARCHIVO"

if [ $? -eq 0 ]; then
    TAMANO=$(du -sh "$ARCHIVO" | cut -f1)
    echo "Backup completado: $ARCHIVO ($TAMANO)"
else
    echo "Error al realizar el backup"
    rm -f "$ARCHIVO"
    exit 1
fi

echo "Eliminando backups con mas de $DIAS_RETENCION dias..."
find "$BACKUP_DIR" -name "backup_*.sql" -mtime +$DIAS_RETENCION -delete
RESTANTES=$(ls "$BACKUP_DIR"/backup_*.sql 2>/dev/null | wc -l)
echo "Backups disponibles: $RESTANTES"
