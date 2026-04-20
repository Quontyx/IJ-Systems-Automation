# IJ Systems Automation

Proyecto TFG de ASIR centrado en la automatización del despliegue y administración de servicios en contenedores mediante Bash, Ansible y Docker.

## Objetivo

Diseñar e implementar un entorno reproducible sobre Ubuntu que permita:

- Preparar el host automáticamente.
- Desplegar servicios en contenedores con Docker Compose.
- Monitorizar el sistema y los contenedores.
- Realizar comprobaciones y copias de seguridad básicas.
- Facilitar la futura migración del entorno a AWS.

## Servicios incluidos

- Nginx
- MariaDB
- Prometheus
- Node Exporter
- cAdvisor
- Uptime Kuma

## Estructura del proyecto

- `scripts/`: scripts Bash
- `ansible/`: inventario, variables y playbook
- `docker/`: Docker Compose, `.env` y contenido web
- `monitoring/`: Prometheus
- `docs/`: capturas, pruebas, errores y gráficas
- `backups/`: copias de seguridad
