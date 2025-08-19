#!/usr/bin/env bash
# Hadassa OS - Desktop (Debian 13 Trixie)
# - Purga GNOME por completo si está presente
# - Instala KDE Plasma (kde-standard) + SDDM (Wayland por defecto)
# - Añade herramientas: LibreOffice ES, Synaptic, FileZilla, Remmina, VLC, htop, btop, Brave

set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

log(){ echo -e "\n==> $*\n"; }
require_root(){ [[ $EUID -eq 0 ]] || { echo "Ejecuta como root (sudo)"; exit 1; }; }
require_root

# Purga GNOME si viene del instalador por defecto
log "Eliminando GNOME (si está instalado)..."
GNOME_PKGS="gdm3 gnome-shell gnome-session gnome-control-center gnome-terminal
gnome-initial-setup task-gnome-desktop gnome-core yelp totem cheese eog eog-plugins"
apt-get purge -y $GNOME_PKGS || true
apt-get autoremove -y --purge || true
systemctl disable gdm3 2>/dev/null || true

log "Instalando KDE Plasma estándar y SDDM..."
apt-get install -y kde-standard sddm
# Componentes Wayland/plasma
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

# Asegurar SDDM como display manager
echo "sddm shared/default-x-display-manager select sddm" | debconf-set-selections || true
dpkg-reconfigure -f noninteractive sddm || true
systemctl enable sddm || true

log "Instalando traducciones de KDE/Plasma y ofimática en español..."
apt-get install -y plasma-workspace-l10n kde-config-cron kde-config-systemd
apt-get install -y libreoffice libreoffice-help-es libreoffice-l10n-es hunspell-es

log "Instalando herramientas: Synaptic, FileZilla, Remmina (RDP/VNC), VLC, htop, btop, Brave..."
apt-get install -y synaptic filezilla remmina remmina-plugin-rdp remmina-plugin-vnc vlc htop btop brave-browser

log "Entorno gráfico preparado (Debian 13 + KDE + Wayland)."
