#!/usr/bin/env bash
# Hadassa OS - Base Installer (Debian 13 Trixie)
# Reemplaza el antiguo script base (Loc-OS/Debian 12) por una instalación limpia sobre Debian 13.
# - No migra a sysvinit ni usa kernels externos.
# - Descarga y ejecuta 3 sub-scripts: dependencia, desktop y customs.
# - Aplica branding Hadassa OS.
# Uso:
#   sudo bash install_hadassa_trixie_base.sh

set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

log(){ echo -e "\n==> $*\n"; }
require_root(){ [[ $EUID -eq 0 ]] || { echo "Ejecuta como root (sudo)"; exit 1; }; }
require_root

#-------------------------------------------------------------------------------
# 1) Actualización base
#-------------------------------------------------------------------------------
log "Actualizando listas y sistema..."
apt-get update -y
apt-get -o Dpkg::Options::="--force-confnew" full-upgrade -y

# Herramientas básicas
log "Instalando utilidades base..."
apt-get install -y curl wget ca-certificates gnupg apt-transport-https sudo

#-------------------------------------------------------------------------------
# 2) Descargar sub-scripts Hadassa OS (ajusta las URLs a tu repo si lo deseas)
#-------------------------------------------------------------------------------
# Si piensas publicarlos en GitHub, cambia BASEURL por tu raw.githubusercontent.com
BASEURL="${HADASSA_BASEURL:-https://raw.githubusercontent.com/Nathanaelrc/Hadassas-OS/main}"

log "Descargando sub-scripts Hadassa OS..."
wget -O /root/hadassa-dependency.sh  "$BASEURL/hadassa-dependency.sh"
wget -O /root/hadassa-desktop.sh     "$BASEURL/hadassa-desktop.sh"
wget -O /root/hadassa-customs.sh     "$BASEURL/hadassa-customs.sh"

chmod +x /root/hadassa-*.sh

#-------------------------------------------------------------------------------
# 3) Ejecutar en orden
#-------------------------------------------------------------------------------
log "Ejecutando hadassa-dependency.sh ..."
bash /root/hadassa-dependency.sh

log "Ejecutando hadassa-desktop.sh ..."
bash /root/hadassa-desktop.sh

log "Ejecutando hadassa-customs.sh ..."
bash /root/hadassa-customs.sh

#-------------------------------------------------------------------------------
# 4) Finalización
#-------------------------------------------------------------------------------
log "Limpieza y finalización..."
apt-get autoremove -y
apt-get autoclean -y
update-grub || true

log "Instalación base Hadassa OS (Debian 13) finalizada."
echo "Reinicia para aplicar todos los cambios: sudo reboot"
