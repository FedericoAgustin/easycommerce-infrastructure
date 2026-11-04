# EasyCommerce - entorno Docker inicial

Este paquete agrega una base de infraestructura para ejecutar EasyCommerce con:
- Backend Spring Boot (Java 21), construido desde el código fuente.
- PostgreSQL 15 con volumen persistente.
- pgAdmin para administrar la base de datos.

## Requisitos

- Docker Desktop instalado y en ejecución.
- Repositorio de EasyCommerce con `pom.xml` y carpeta `src/` en la misma raíz que estos archivos.

## Integración

Copiá estos archivos en la raíz del repositorio, donde están `pom.xml` y `src/`.
No reemplaces ni borres el código fuente existente.

## Configuración

El archivo `.env` incluido contiene credenciales de ejemplo para desarrollo local.
No lo subas a GitHub. Está excluido mediante `.gitignore` y `.dockerignore`.

Revisá que `src/main/resources/application.yml` lea estas variables:
- `DB_NAME`
- `DB_USER`
- `DB_PASSWORD`
- `PORT`

La URL JDBC que recibe el backend es:
`jdbc:postgresql://db:5432/easyecommerce`

Dentro de Docker, el host de PostgreSQL es `db`, no `localhost`.

## Construir y ejecutar

Desde PowerShell, en la raíz del proyecto:

```powershell
docker compose config
docker compose up -d --build
docker compose ps
docker compose logs -f app
```

## Direcciones

- API: http://localhost:8081
- Swagger UI (si está habilitado): http://localhost:8081/swagger-ui/index.html
- pgAdmin: http://localhost:5050

Para conectar pgAdmin con PostgreSQL:
- Host: `db`
- Puerto: `5432`
- Base de mantenimiento: `easyecommerce`
- Usuario: `easyadmin`
- Contraseña: la definida en `.env`

## Detener servicios

```powershell
docker compose down
```

Los datos se conservan en los volúmenes.

Para eliminar también los datos persistidos (operación destructiva):

```powershell
docker compose down -v
```

## Importante: adaptar antes de ejecutar

Este Dockerfile presupone que:
1. El proyecto usa Maven.
2. `pom.xml` está en la raíz.
3. El artefacto ejecutable se genera en `target/`.
4. La aplicación escucha en el puerto 8081.
5. `application.yml` utiliza las variables indicadas.

El README original menciona las variables `DB_NAME`, `DB_USER`, `DB_PASSWORD` y `PORT`, pero hay que comprobar el `application.yml` real para confirmar que coincidan.

`-DskipTests` se usa solamente para la primera puesta en marcha. Para CI/CD conviene ejecutar las pruebas y bloquear la construcción si fallan.
