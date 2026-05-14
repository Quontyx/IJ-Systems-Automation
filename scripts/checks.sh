#!/bin/bash

echo "===== VERSIONES ====="
docker --version
docker compose version
ansible --version | head -n 1

echo
echo "===== CONTENEDORES ====="
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo
echo "===== REDES ====="
docker network ls

echo
echo "===== VOLUMENES ====="
docker volume ls

echo
echo "===== PRUEBAS HTTP ====="

echo "Nginx (puerto 80):"
curl -s -o /dev/null -w "  HTTP %{http_code} en %{time_total}s\n" http://localhost || echo "  No responde"

echo "Prometheus (puerto 9090):"
curl -s -o /dev/null -w "  HTTP %{http_code} en %{time_total}s\n" http://localhost:9090 || echo "  No responde"

echo "Uptime Kuma (puerto 3001):"
curl -s -o /dev/null -w "  HTTP %{http_code} en %{time_total}s\n" http://localhost:3001 || echo "  No responde"

echo "cAdvisor (puerto 8080):"
curl -s -o /dev/null -w "  HTTP %{http_code} en %{time_total}s\n" http://localhost:8080 || echo "  No responde"

echo
echo "===== BASE DE DATOS ====="
docker exec mariadb mariadb -u root -p"${MYSQL_ROOT_PASSWORD:-root}" -e "SELECT 'MariaDB operativa' AS estado;" 2>/dev/null   && echo "  Conexion correcta" || echo "  No se pudo conectar a MariaDB"

echo
echo "===== USO DE RECURSOS ====="
docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"

echo
echo "===== FIN DE COMPROBACIONES ====="
