#!/usr/bin/env bash
# Hadassa OS - Desktop (Debian 13 Trixie)
# - KDE Plasma (Wayland por defecto con SDDM)
# - LibreOffice ES, Synaptic, Brave, herramientas

set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

log(){ echo -e "\n==> $*\n"; }
require_root(){ [[ $EUID -eq 0 ]] || { echo "Ejecuta como root (sudo)"; exit 1; }; }
require_root

log "Instalando KDE Plasma estándar y SDDM..."
apt-get install -y kde-standard sddm
apt-get install -y plasma-workspace kwin-wayland xwayland

log "Forzando Wayland por defecto en SDDM..."
install -d /etc/sddm.conf.d
cat >/etc/sddm.conf.d/10-wayland.conf <<'SDDMEOF'
[General]
DisplayServer=wayland

[Wayland]
CompositorCommand=kwin_wayland
EnableHiDPI=true
SDDMEOF

cat >/etc/sddm.conf.d/20-session.conf <<'SESSCONF'
[Autologin]
Session=plasmawayland.desktop
SESSCONF

echo "sddm shared/default-x-display-manager select sddm" | debconf-set-selections || true
dpkg-reconfigure -f noninteractive sddm || true

log "Instalando traducciones KDE/Plasma y ofimática en español..."
apt-get install -y plasma-workspace-l10n kde-config-cron kde-config-systemd
apt-get install -y libreoffice libreoffice-help-es libreoffice-l10n-es hunspell-es

log "Instalando herramientas: Synaptic, FileZilla, Remmina (RDP/VNC), VLC, htop, btop, Brave..."
apt-get install -y synaptic filezilla remmina remmina-plugin-rdp remmina-plugin-vnc vlc htop btop brave-browser

log "Componente gráfico listo."
