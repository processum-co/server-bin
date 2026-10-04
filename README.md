# Processum Server — Distribucion Oficial de Binarios Ejecutables

> Repositorio de distribucion oficial de ejecutables independientes y artefactos de despliegue para Processum Backend API.

Este repositorio almacena y distribuye los artefactos compilados generados automaticamente por el pipeline de integracion continua de [`processum-co/server`](https://github.com/processum-co/server), permitiendo desplegar la plataforma judicial sin exponer el codigo fuente ni requerir runtimes adicionales (Node.js, Bun o compiladores) en el servidor de destino.

---

## Caracteristicas de la Distribucion

1. **Autocontenido y de Alto Rendimiento:** Cada binario encapsula el runtime de ejecucion, la infraestructura HTTP Fastify y todas las dependencias del sistema en un solo archivo ejecutable.
2. **Cero Dependencias Externas:** No se requiere instalar Node.js, Bun, npm ni herramientas de construccion en el host de produccion.
3. **Arranque Instantaneo:** Tiempo de inicializacion en milisegundos con minimo consumo de memoria RAM.
4. **Proteccion de Propiedad Intelectual:** Permite la distribucion a clientes y entornos on-premise garantizando la seguridad del codigo fuente.
5. **Arquitectura Multi-Motor de Datos:** Soporte integrado para Microsoft SQL Server, PostgreSQL y almacenamiento en memoria mediante seleccion en variable de entorno.

---

## Compatibilidad de Arquitecturas

| Plataforma | Binario Objetivo | Entornos Recomendados |
| :--- | :--- | :--- |
| **Linux x64** | `processum-server-linux-x64` | Ubuntu, Debian, RHEL, Rocky Linux, Contenedores Docker |
| **Linux ARM64** | `processum-server-linux-arm64` | AWS Graviton, GCP Tau T2A, Raspberry Pi 4/5 |
| **Windows x64** | `processum-server-windows-x64.exe` | Windows Server 2019/2022, Windows 10/11 Pro |
| **macOS ARM64** | `processum-server-darwin-arm64` | Apple Silicon (M1/M2/M3) para pruebas locales |

---

## Estructura del Repositorio

```text
server-bin/
├── .env.example                     # Plantilla de variables de entorno de produccion
├── .gitignore                       # Exclusion de archivos locales y temporales
├── Dockerfile                       # Definicion de contenedor basada en debian-slim
├── docker-compose.yml               # Orquestacion para despliegue en un solo comando
├── README.md                        # Documentacion de instalacion y operacion
├── scripts/
│   ├── install.sh                   # Descargador e instalador automatico para Linux/macOS
│   └── install.ps1                  # Descargador e instalador automatico para Windows
└── systemd/
    └── processum-server.service     # Unidad de servicio systemd para servidores Linux
```

---

## Guia de Inicio Rapido

### 1. Configuracion del Entorno

Copie la plantilla de variables de entorno y configure los parametros segun su infraestructura:

```bash
# En sistemas Linux / macOS
cp .env.example .env

# En sistemas Windows PowerShell
Copy-Item .env.example .env
```

Edite `.env` para indicar el motor de base de datos (`DATABASE_ENGINE=sqlserver` o `postgresql`) y la clave secreta `JWT_SECRET`.

### 2. Obtencion del Ejecutable

#### Opcion A: Descarga Automatica mediante Script

- **Linux / macOS:**
  ```bash
  chmod +x scripts/install.sh
  ./scripts/install.sh
  ```

- **Windows:**
  ```powershell
  .\scripts\install.ps1
  ```

#### Opcion B: Descarga desde GitHub Releases
Descargue el binario correspondiente a su arquitectura directamente desde la seccion [Releases](https://github.com/processum-co/server-bin/releases) y guardelo dentro de la carpeta `bin/`.

### 3. Ejecucion del Servidor

#### Ejecucion Directa (Standalone)

- **Linux:**
  ```bash
  chmod +x bin/processum-server-linux-x64
  ./bin/processum-server-linux-x64
  ```

- **Windows:**
  ```powershell
  .\bin\processum-server-windows-x64.exe
  ```

#### Ejecucion con Docker Compose

```bash
docker compose up -d
```

#### Ejecucion como Servicio del Sistema (systemd en Linux)

```bash
# 1. Copiar binario a la ubicacion estandar
sudo mkdir -p /opt/processum/bin
sudo cp bin/processum-server-linux-x64 /opt/processum/bin/
sudo cp .env /opt/processum/.env

# 2. Instalar el servicio systemd
sudo cp systemd/processum-server.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now processum-server

# 3. Verificar estado
sudo systemctl status processum-server
```

---

## Verificacion y Diagnostico

Una vez iniciado el servicio, compruebe su funcionamiento en las siguientes URLs:

- **Comprobacion de Salud:** `GET http://localhost:3000/health`
- **Documentacion Interactiva Swagger UI:** `GET http://localhost:3000/docs`
- **Especificacion OpenAPI JSON:** `GET http://localhost:3000/docs/json`

---

## Politica Operativa

Este proyecto y sus artefactos se rigen por la politica corporativa de cero emojis en codigo, logs y documentacion.
