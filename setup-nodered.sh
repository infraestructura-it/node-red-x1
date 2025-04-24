#!/bin/bash

echo "🔧 Iniciando configuración del proyecto Node-RED..."

# Nombre del directorio raíz del proyecto
PROYECTO="nodered-flujos"

# Paso 1: Crear estructura de carpetas
mkdir -p "$PROYECTO/.node-red"
mkdir -p "$PROYECTO/.devcontainer"

cd "$PROYECTO" || exit 1

# Paso 2: Crear archivos necesarios

# README.md
cat <<EOF > README.md
# Proyecto Node-RED

Este proyecto contiene flujos y configuración de Node-RED para usar localmente o en GitHub Codespaces.
EOF

# flows.json
cat <<EOF > flows.json
[
  {
    "id": "inject1",
    "type": "inject",
    "name": "Hola Mundo",
    "props": [],
    "repeat": "",
    "crontab": "",
    "once": true,
    "onceDelay": 0.1,
    "wires": [["debug1"]]
  },
  {
    "id": "debug1",
    "type": "debug",
    "name": "Salida",
    "active": true,
    "tosidebar": true,
    "wires": []
  }
]
EOF

# .gitignore
cat <<EOF > .gitignore
node_modules/
.npm/
*.log
EOF

# .devcontainer/devcontainer.json (opcional)
cat <<EOF > .devcontainer/devcontainer.json
{
  "name": "Node-RED Dev",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
    "ghcr.io/devcontainers/features/node:1": {
      "version": "18"
    }
  },
  "postCreateCommand": "./setup-nodered.sh"
}
EOF

# Volver al root del script para instalación
cd ..

# Paso 3: Instalar Node-RED globalmente
echo "📦 Instalando Node-RED..."
npm install -g --unsafe-perm node-red

# Paso 4: Copiar el flujo al home de Node-RED del usuario
echo "📁 Copiando flujo a ~/.node-red"
mkdir -p ~/.node-red
cp "$PROYECTO/flows.json" ~/.node-red/flows.json

# Paso 5: Confirmación
echo "✅ Proyecto Node-RED listo."
echo "🌐 Para iniciar, ejecutá: node-red"
echo "🌍 Accedé desde: http://localhost:1880"

# Mostrar estructura
echo "📁 Estructura generada:"
tree -a "$PROYECTO" || ls -R "$PROYECTO"
