#!/data/data/com.termux/files/usr/bin/bash

set -e

# Colores
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

show_banner() {
  echo -e "${YELLOW}Git LFS CLI Tool for Termux${RESET}"
  echo -e "${RED}¡Advertencia! GitHub solo permite 2 GB de almacenamiento gratuito al mes para Git LFS.${RESET}"
  echo ""
}

install_git_lfs() {
  echo -e "${GREEN}Instalando Git LFS...${RESET}"
  pkg install -y git-lfs
  git lfs install
  echo -e "${GREEN}Git LFS instalado y configurado.${RESET}"
}

track_filetype() {
  echo -e "${YELLOW}Archivos que deseas rastrear con Git LFS (ej: *.zip, *.tar.gz):${RESET}"
  read -p "Patrón: " pattern
  git lfs track "$pattern"
  git add .gitattributes
  echo -e "${GREEN}Archivo rastreado: $pattern${RESET}"
}

add_commit_push() {
  echo -e "${YELLOW}Ruta del archivo a agregar:${RESET}"
  read -p "Archivo: " file
  git add "$file"
  echo -e "${YELLOW}Mensaje del commit:${RESET}"
  read -p "Mensaje: " message
  git commit -m "$message"
  git push
  echo -e "${GREEN}Archivo enviado a GitHub con LFS.${RESET}"
}

menu() {
  show_banner
  echo "1) Instalar Git LFS"
  echo "2) Rastrear archivo con LFS"
  echo "3) Agregar + Commit + Push"
  echo "4) Salir"
  echo ""

  read -p "Elige una opción: " option

  case $option in
    1) install_git_lfs ;;
    2) track_filetype ;;
    3) add_commit_push ;;
    4) echo "Saliendo..." && exit 0 ;;
    *) echo "Opción inválida" && sleep 1 && menu ;;
  esac
}

while true; do
  menu
done
