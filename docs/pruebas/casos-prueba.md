# Casos de prueba

## CP-01 - Validación de Docker Compose
- Fecha/autor/versión: 25/04/2026 / Ian Gutiérrez / v1.0
- Descripción: comprobar que la sintaxis del fichero docker-compose.yml es correcta.
- Condiciones de ejecución: estructura del proyecto creada y fichero .env disponible.
- Entrada: docker compose config
- Resultado esperado: Docker Compose valida la configuración sin errores.
- Resultado obtenido: Docker Compose muestra la configuración completa expandida sin ningún error ni advertencia. Todas las variables del fichero .env se sustituyen correctamente.
- Evaluación: Correcto

## CP-02 - Arranque de contenedores
- Fecha/autor/versión: 25/04/2026 / Ian Gutiérrez / v1.0
- Descripción: levantar la pila completa de contenedores.
- Condiciones de ejecución: Docker funcionando correctamente.
- Entrada: docker compose up -d
- Resultado esperado: todos los contenedores se crean y arrancan.
- Resultado obtenido: Los 6 contenedores (nginx, uptime-kuma, mariadb, prometheus, node-exporter, cadvisor) se crean y arrancan correctamente. Todos aparecen en estado Up al ejecutar docker ps.
- Evaluación: Correcto

## CP-03 - Acceso a Nginx
- Fecha/autor/versión: 25/04/2026 / Jaime Ferrari / v1.0
- Descripción: comprobar la publicación de la web de prueba.
- Condiciones de ejecución: contenedor Nginx en ejecución.
- Entrada: http://IP_VM
- Resultado esperado: carga de la página web del proyecto.
- Resultado obtenido: El navegador carga correctamente la página personalizada con el título IJ Systems Automation y el texto Despliegue automatizado con Bash, Ansible y Docker. El servidor responde con código HTTP 200.
- Evaluación: Correcto

## CP-04 - Estado de métricas en Prometheus
- Fecha/autor/versión: 26/04/2026 / Jaime Ferrari / v1.0
- Descripción: verificar los targets configurados.
- Condiciones de ejecución: Prometheus, node-exporter y cadvisor en ejecución.
- Entrada: http://IP_VM:9090
- Resultado esperado: targets en estado UP.
- Resultado obtenido: Los tres targets definidos en prometheus.yml (prometheus, node-exporter y cadvisor) aparecen en estado UP en la sección Status > Targets. El scrape interval de 15s se aplica correctamente en todos ellos.
- Evaluación: Correcto

## CP-05 - Acceso a Uptime Kuma
- Fecha/autor/versión: 26/04/2026 / Ian Gutiérrez / v1.0
- Descripción: comprobar que Uptime Kuma carga y muestra el estado de los servicios monitorizados.
- Condiciones de ejecución: contenedor uptime-kuma en ejecución.
- Entrada: http://IP_VM:3001
- Resultado esperado: acceso correcto al panel de disponibilidad con los servicios configurados.
- Resultado obtenido: El panel de Uptime Kuma carga correctamente en el puerto 3001. Se accede al panel de administración y se visualizan los monitores configurados para los servicios del proyecto con su estado de disponibilidad actualizado.
- Evaluación: Correcto

## CP-06 - Backup de MariaDB
- Fecha/autor/versión: 25/04/2026 / Ian Gutiérrez / v1.0
- Descripción: generar una copia de seguridad de la base de datos.
- Condiciones de ejecución: contenedor MariaDB en ejecución.
- Entrada: ./backup.sh
- Resultado esperado: creación de un archivo .sql en la carpeta backups.
- Resultado obtenido: El script genera correctamente el fichero backup_2026-04-25_14-18-08.sql en la carpeta backups/. El archivo contiene el volcado completo de la base de datos ijdb. El script finaliza con el mensaje Backup realizado correctamente.
- Evaluación: Correcto
