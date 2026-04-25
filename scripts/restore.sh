#!/bin/bash

BACKUP_DIR="$HOME/IJ-Systems-Automation/backups"

if [ -z "$1" ]; then
    echo "Uso: ./restore.sh nombre_del_backup.sql"
    exit 1
fi

ARCHIVO="$BACKUP_DIR/$1"

if [ ! -f "$ARCHIVO" ]; then
    echo "No existe el archivo: $ARCHIVO"
    exit 1
fi

docker exec -i mariadb mariadb -u root -proot1234 ijdb < "$ARCHIVO"

if [ $? -eq 0 ]; then
    echo "Restauración completada correctamente"
else
    echo "Error durante la restauración"
fi
