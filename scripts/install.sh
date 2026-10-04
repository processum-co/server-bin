#!/usr/bin/env bash
# ==============================================================================
# Processum Server — Instalador Automatizado para Linux / macOS
# ==============================================================================

set -euo pipefail

REPO="processum-co/server-bin"
TARGET_DIR="${TARGET_DIR:-./bin}"
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"

case "${ARCH}" in
  x86_64|amd64)
    ARCH_SUFFIX="x64"
    ;;
  aarch64|arm64)
    ARCH_SUFFIX="arm64"
    ;;
  *)
    echo "Arquitectura no soportada: ${ARCH}" >&2
    exit 1
    ;;
esac

case "${OS}" in
  linux)
    BINARY_NAME="processum-server-linux-${ARCH_SUFFIX}"
    ;;
  darwin)
    BINARY_NAME="processum-server-darwin-${ARCH_SUFFIX}"
    ;;
  *)
    echo "Sistema operativo no soportado por este script: ${OS}" >&2
    exit 1
    ;;
esac

mkdir -p "${TARGET_DIR}"

echo "Consultando ultima version publicada en ${REPO}..."
LATEST_RELEASE=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

if [ -z "${LATEST_RELEASE}" ]; then
  echo "No se encontro ninguna version publicada en GitHub Releases. Utilizando binario local si existe."
  exit 0
fi

DOWNLOAD_URL="https://github.com/${REPO}/releases/download/${LATEST_RELEASE}/${BINARY_NAME}"
OUTPUT_PATH="${TARGET_DIR}/${BINARY_NAME}"

echo "Descargando ${BINARY_NAME} desde ${DOWNLOAD_URL}..."
curl -fsSL -o "${OUTPUT_PATH}" "${DOWNLOAD_URL}"
chmod +x "${OUTPUT_PATH}"

echo "Instalacion completada en: ${OUTPUT_PATH}"
