#!/usr/bin/env bash
# Hadassa OS - Base Installer (Debian 13 Trixie)
# Ejecuta los sub-scripts: dependency -> desktop -> customs
# Uso: sudo bash install_hadassa_trixie_base.sh

set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

log(){ echo -e "\n==> $*\n"; }
require_root(){ [[ $EUID -eq 0 ]] || { echo "Ejecuta como root (sudo)"; exit 1; }; }
require_root

log "Actualizando listas y sistema (Debian 13 Trixie)..."
apt-get update -y
apt-get -o Dpkg::Options::="--force-confnew" full-upgrade -y

log "Instalando utilidades base (sin paquetes obsoletos)..."
apt-get install -y curl wget ca-certificates gnupg sudo

# URL base de descarga (ajústala a tu repo)
BASEURL="${HADASSA_BASEURL:-https://raw.githubusercontent.com/Nathanaelrc/Hadassas-OS/main}"

log "Descargando sub-scripts Hadassa OS..."
wget -O /root/hadassa-dependency.sh  "$BASEURL/hadassa-dependency.sh"
wget -O /root/hadassa-desktop.sh     "$BASEURL/hadassa-desktop.sh"
wget -O /root/hadassa-customs.sh     "$BASEURL/hadassa-customs.sh"
chmod +x /root/hadassa-*.sh

log "Ejecutando hadassa-dependency.sh ..."
bash /root/hadassa-dependency.sh

log "Ejecutando hadassa-desktop.sh ..."
bash /root/hadassa-desktop.sh

log "Ejecutando hadassa-customs.sh ..."
bash /root/hadassa-customs.sh

log "Limpieza final..."
apt-get autoremove -y --purge
apt-get autoclean -y
update-grub || true

log "Instalación base Hadassa OS (Debian 13) finalizada. Reinicia para aplicar todo."
