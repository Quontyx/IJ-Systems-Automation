#!/bin/bash

echo "===== VERSIONES ====="
docker --version
docker compose version
ansible --version | head -n 1

echo
echo "===== CONTENEDORES ====="
docker ps

echo
echo "===== REDES ====="
docker network ls

echo
echo "===== VOLUMENES ====="
docker volume ls

echo
echo "===== PRUEBAS HTTP ====="

echo "Nginx:"
curl -I http://localhost || true

echo
echo "Prometheus:"
curl -I http://localhost:9090 || true

echo
echo "Uptime Kuma:"
curl -I http://localhost:3001 || true

echo
echo "cAdvisor:"
curl -I http://localhost:8080 || true

echo
echo "===== FIN DE COMPROBACIONES ====="
