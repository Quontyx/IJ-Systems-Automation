# IJ Systems Automation

<p align="center">
  Automatización del despliegue y administración de servicios en contenedores — <strong>reproducible, monitorizado y listo para producción</strong>.
</p>

<p align="center">
  <img alt="Bash" src="https://img.shields.io/badge/Bash-5-4EAA25?logo=gnubash&logoColor=white"/>
  <img alt="Ansible" src="https://img.shields.io/badge/Ansible-2.x-EE0000?logo=ansible&logoColor=white"/>
  <img alt="Docker" src="https://img.shields.io/badge/Docker_Compose-2496ED?logo=docker&logoColor=white"/>
  <img alt="Prometheus" src="https://img.shields.io/badge/Prometheus-v3-E6522C?logo=prometheus&logoColor=white"/>
  <img alt="Ubuntu" src="https://img.shields.io/badge/Ubuntu-22.04-E95420?logo=ubuntu&logoColor=white"/>
  <img alt="License" src="https://img.shields.io/badge/licencia-MIT-blue"/>
</p>

---

Proyecto TFG de **ASIR** desarrollado por Ian Gutiérrez y Jaime, centrado en diseñar un entorno de infraestructura reproducible sobre Ubuntu que automatiza desde la preparación del host hasta el despliegue y monitorización de servicios en contenedores.

Un solo comando prepara el sistema, despliega los servicios y arranca la monitorización completa. Sin pasos manuales, sin configuraciones ocultas.

## ¿Por qué IJ Systems?

El despliegue manual de infraestructura es lento, propenso a errores y difícil de replicar. IJ Systems resuelve exactamente eso.

| | IJ Systems Automation | Despliegue manual |
|---|---|---|
| Preparación del host automatizada | ✅ | ❌ |
| Entorno 100% reproducible | ✅ | ❌ |
| Monitorización de contenedores incluida | ✅ | ❌ |
| Copias de seguridad automáticas | ✅ | ❌ |
| Separación de redes por función | ✅ | Raro |
| Healthchecks integrados | ✅ | Manual |
| Preparado para migración a AWS | ✅ | ❌ |
| Código abierto | ✅ | — |

## Características

- **Preparación automática del host** — El script `instalar.sh` detecta el entorno, instala Docker desde el repositorio oficial y configura los permisos necesarios sin intervención manual.
- **Orquestación con Ansible** — El playbook gestiona la configuración del servidor, instalación de paquetes base e inicialización del servicio Docker de forma idempotente.
- **Servicios en red segmentada** — Tres redes Docker aisladas (`frontend`, `backend`, `monitoring`) con IPs estáticas para cada contenedor.
- **Monitorización completa** — Stack Prometheus + Node Exporter + cAdvisor captura métricas del sistema operativo y de cada contenedor en tiempo real.
- **Disponibilidad con Uptime Kuma** — Panel visual para supervisar el estado de los servicios con alertas configurables.
- **Base de datos persistente** — MariaDB con volumen Docker, healthcheck integrado y variables de entorno separadas del código via `.env`.
- **Backups y restauración** — Scripts `backup.sh` y `restore.sh` para copias de seguridad y recuperación de datos.
- **Comprobaciones de integridad** — `checks.sh` verifica el estado del entorno antes y después del despliegue.

## Stack tecnológico

| Capa | Tecnología |
|---|---|
| Automatización de host | Bash 5, Ansible 2.x |
| Orquestación de contenedores | Docker Compose |
| Servidor web | Nginx 1.27 |
| Base de datos | MariaDB 11.4 |
| Métricas del sistema | Prometheus v3.11, Node Exporter v1.11 |
| Métricas de contenedores | cAdvisor v0.55 |
| Monitorización de disponibilidad | Uptime Kuma 1.23 |
| SO objetivo | Ubuntu 22.04 LTS |

## Arquitectura

```
IJ-Systems-Automation/
├── scripts/                    # Automatización Bash
│   ├── instalar.sh             # Instala Docker, Ansible y herramientas base
│   ├── checks.sh               # Comprobaciones de integridad del entorno
│   ├── backup.sh               # Copia de seguridad de volúmenes y configuración
│   └── restore.sh              # Restauración desde backup
│
├── ansible/                    # Gestión de configuración
│   ├── inventory.ini           # Hosts objetivo
│   ├── group_vars/
│   │   └── all.yml             # Variables globales (usuario, paquetes…)
│   └── playbook.yml            # Preparación completa del servidor
│
├── docker/                     # Definición de servicios
│   ├── docker-compose.yml      # 6 servicios, 3 redes, 2 volúmenes persistentes
│   ├── .env.example            # Plantilla de variables de entorno
│   └── nginx/
│       └── index.html          # Página web servida por Nginx
│
├── monitoring/
│   └── prometheus/
│       └── prometheus.yml      # Configuración de scraping de métricas
│
├── docs/
│   └── pruebas/
│       └── casos-prueba.md     # Resultados y casos de prueba documentados
│
└── backups/                    # Almacenamiento de copias de seguridad
```

## Servicios y puertos

| Servicio | Puerto | Red | Descripción |
|---|---|---|---|
| Nginx | `80` | frontend | Servidor web principal |
| Uptime Kuma | `3001` | frontend | Panel de monitorización de disponibilidad |
| MariaDB | — | backend | Base de datos (sin exposición externa) |
| Prometheus | `9090` | monitoring | Recolección y consulta de métricas |
| cAdvisor | `8080` | monitoring | Métricas en tiempo real de contenedores |
| Node Exporter | — | monitoring | Métricas del sistema operativo del host |

## Requisitos previos

| Componente | Requisito |
|---|---|
| Sistema operativo | Ubuntu 22.04 LTS |
| RAM mínima | 2 GB |
| Disco libre | 10 GB |
| Acceso | Usuario con privilegios `sudo` |
| Conectividad | Acceso a internet para descarga de imágenes |

> [!NOTE]
> Docker y Ansible se instalan automáticamente con `instalar.sh`. No es necesario preinstalar nada más allá de un Ubuntu base.

## Instalación y despliegue

### 1. Clonar el repositorio

```bash
git clone https://github.com/Quontyx/IJ-Systems-Automation.git
cd IJ-Systems-Automation
```

### 2. Preparar el host

```bash
chmod +x scripts/instalar.sh
./scripts/instalar.sh
```

> [!TIP]
> Si Docker muestra un error de permisos tras la instalación, cierra sesión y vuelve a entrar para que el grupo `docker` surta efecto.

### 3. Configurar variables de entorno

```bash
cp docker/.env.example docker/.env
# Edita docker/.env con tus credenciales
nano docker/.env
```

### 4. Configurar el inventario de Ansible

```bash
# Edita ansible/inventory.ini con la IP o hostname del servidor objetivo
nano ansible/inventory.ini
```

### 5. Ejecutar el playbook de Ansible

```bash
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml --ask-become-pass
```

### 6. Levantar los servicios

```bash
docker compose -f docker/docker-compose.yml up -d
```

### 7. Verificar el entorno

```bash
chmod +x scripts/checks.sh
./scripts/checks.sh
```

## Backups y restauración

```bash
# Crear copia de seguridad
chmod +x scripts/backup.sh
./scripts/backup.sh

# Restaurar desde backup
chmod +x scripts/restore.sh
./scripts/restore.sh
```

> [!WARNING]
> Los backups se almacenan en `backups/`. Asegúrate de mover o copiar estas copias a un almacenamiento externo de forma regular.

## Roadmap

Las siguientes mejoras están planificadas como trabajo futuro:

- [ ] **Migración a AWS** — Adaptar la infraestructura para despliegue en EC2 con Terraform.
- [ ] **Alertas de Prometheus** — Configurar Alertmanager con notificaciones por correo o Slack.
- [ ] **Dashboard Grafana** — Visualización avanzada de métricas sobre Prometheus.
- [ ] **CI/CD básico** — Pipeline con GitHub Actions para validación automática de playbooks y compose.
- [ ] **Gestión de secretos** — Integrar Ansible Vault para cifrar credenciales sensibles en el repositorio.
- [ ] **Soporte multi-host** — Escalar el inventario Ansible para gestionar varios nodos simultáneamente.

## Autores

- Ian Gutiérrez — GitHub: **[@Quontyx](https://github.com/Quontyx)**
- Jaime

---

<p align="center">Hecho con ☕ y demasiadas horas de terminal</p>

---
