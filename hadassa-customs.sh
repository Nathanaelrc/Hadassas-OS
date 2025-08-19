#!/usr/bin/env bash
# Hadassa OS - Customs & Branding (Debian 13 Trixie)
# - Branding (hostname + banners + GRUB)
# - Usuarios: root/live (contraseñas débiles para pruebas; cambiar luego)
# - Limpieza

set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

log(){ echo -e "\n==> $*\n"; }
require_root(){ [[ $EUID -eq 0 ]] || { echo "Ejecuta como root (sudo)"; exit 1; }; }
require_root

# Branding
log "Aplicando branding Hadassa OS..."
NEW_HOSTNAME="hadassa-os"
hostnamectl set-hostname "$NEW_HOSTNAME"
echo "$NEW_HOSTNAME" >/etc/hostname

cat >/etc/issue <<'ISSUEEOF'
Hadassa OS \n \l
ISSUEEOF

cat >/etc/motd <<'MOTDEOF'
Bienvenido a Hadassa OS
MOTDEOF

if grep -q '^GRUB_DISTRIBUTOR=' /etc/default/grub; then
  sed -i 's/^GRUB_DISTRIBUTOR=.*/GRUB_DISTRIBUTOR="Hadassa OS"/' /etc/default/grub
else
  echo 'GRUB_DISTRIBUTOR="Hadassa OS"' >> /etc/default/grub
fi
update-grub || true

# Info adicional (no toca /etc/os-release del sistema)
cat >/etc/lsb-release <<'LSBEOF'
PRETTY_NAME="Hadassa OS (based on Debian 13 Trixie)"
DISTRIB_ID=HadassaOS
DISTRIB_RELEASE=13
DISTRIB_CODENAME=Trixie
DISTRIB_DESCRIPTION="Hadassa OS (based on Debian 13 Trixie)"
LSBEOF

# Usuarios
log "Configurando usuarios root/live (cambiar contraseñas tras instalar)..."
echo "root:root" | chpasswd
if ! id -u live >/dev/null 2>&1; then
  useradd -m -s /bin/bash -G sudo live
  echo "live:live" | chpasswd
fi

# Limpieza
log "Limpieza final..."
apt-get autoremove -y --purge
apt-get autoclean -y

log "Customs & branding aplicados. Reinicia para ver todos los cambios."
