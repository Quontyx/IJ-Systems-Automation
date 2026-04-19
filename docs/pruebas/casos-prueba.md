# Casos de prueba

## CP-01 - Validación de Docker Compose
- Fecha/autor/versión: [Rellenar]
- Descripción: comprobar que la sintaxis del fichero docker-compose.yml es correcta.
- Condiciones de ejecución: estructura del proyecto creada y fichero .env disponible.
- Entrada: docker compose config
- Resultado esperado: Docker Compose valida la configuración sin errores.
- Resultado obtenido: [Rellenar]
- Evaluación: [Correcto / Incorrecto]

## CP-02 - Arranque de contenedores
- Fecha/autor/versión: [Rellenar]
- Descripción: levantar la pila completa de contenedores.
- Condiciones de ejecución: Docker funcionando correctamente.
- Entrada: docker compose up -d
- Resultado esperado: todos los contenedores se crean y arrancan.
- Resultado obtenido: [Rellenar]
- Evaluación: [Correcto / Incorrecto]

## CP-03 - Acceso a Nginx
- Fecha/autor/versión: [Rellenar]
- Descripción: comprobar la publicación de la web de prueba.
- Condiciones de ejecución: contenedor Nginx en ejecución.
- Entrada: http://IP_VM
- Resultado esperado: carga de la página web del proyecto.
- Resultado obtenido: [Rellenar]
- Evaluación: [Correcto / Incorrecto]

## CP-04 - Estado de métricas en Prometheus
- Fecha/autor/versión: [Rellenar]
- Descripción: verificar los targets configurados.
- Condiciones de ejecución: Prometheus, node-exporter y cadvisor en ejecución.
- Entrada: http://IP_VM:9090
- Resultado esperado: targets en estado UP.
- Resultado obtenido: [Rellenar]
- Evaluación: [Correcto / Incorrecto]

## CP-05 - Acceso a Grafana
- Fecha/autor/versión: [Rellenar]
- Descripción: comprobar que Grafana carga y detecta la fuente Prometheus.
- Condiciones de ejecución: Grafana y Prometheus en ejecución.
- Entrada: http://IP_VM:3000
- Resultado esperado: acceso correcto al panel y datasource disponible.
- Resultado obtenido: [Rellenar]
- Evaluación: [Correcto / Incorrecto]

## CP-06 - Backup de MariaDB
- Fecha/autor/versión: [Rellenar]
- Descripción: generar una copia de seguridad de la base de datos.
- Condiciones de ejecución: contenedor MariaDB en ejecución.
- Entrada: ./backup.sh
- Resultado esperado: creación de un archivo .sql en la carpeta backups.
- Resultado obtenido: [Rellenar]
- Evaluación: [Correcto / Incorrecto]
