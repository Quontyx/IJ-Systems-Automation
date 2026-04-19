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
curl -I http://localhost || true
curl -I http://localhost:3000 || true
curl -I http://localhost:9090 || true
curl -I http://localhost:3001 || true

echo
echo "===== FIN DE COMPROBACIONES ====="
