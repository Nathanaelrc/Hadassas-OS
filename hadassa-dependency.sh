#!/usr/bin/env bash
# Hadassa OS - Dependencias (Debian 13 Trixie)
# - Configura locales (es_CL/es_ES) y teclado latam
# - Añade repo de Brave
# - Evita paquetes obsoletos de Debian 12

set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

log(){ echo -e "\n==> $*\n"; }
require_root(){ [[ $EUID -eq 0 ]] || { echo "Ejecuta como root (sudo)"; exit 1; }; }
require_root

log "Instalando locales y teclado..."
apt-get install -y locales keyboard-configuration console-setup

# Habilitar es_CL y es_ES
if ! grep -qE '^(es_CL.UTF-8|es_ES.UTF-8)' /etc/locale.gen; then
  sed -i 's/^# *\(es_ES.UTF-8\)/\1/' /etc/locale.gen || true
  grep -q '^es_CL.UTF-8 UTF-8' /etc/locale.gen || echo "es_CL.UTF-8 UTF-8" >> /etc/locale.gen
fi
locale-gen

DEFAULT_LOCALE="es_CL.UTF-8"
if ! locale -a | grep -qi "^${DEFAULT_LOCALE,,}$"; then
  DEFAULT_LOCALE="es_ES.UTF-8"
fi
update-locale LANG="$DEFAULT_LOCALE" LANGUAGE="es_CL:es_ES:en_US"

log "Configurando teclado latam (consola/base)..."
if [ -f /etc/default/keyboard ]; then
  sed -i 's/^XKBLAYOUT=.*/XKBLAYOUT="latam"/' /etc/default/keyboard || true
  if grep -q '^XKBVARIANT=' /etc/default/keyboard; then
    sed -i 's/^XKBVARIANT=.*/XKBVARIANT=""/' /etc/default/keyboard || true
  else
    echo 'XKBVARIANT=""' >> /etc/default/keyboard
  fi
else
  cat >/etc/default/keyboard <<'KBEOF'
XKBMODEL="pc105"
XKBLAYOUT="latam"
XKBVARIANT=""
XKBOPTIONS=""
BACKSPACE="guess"
KBEOF
fi
setupcon || true

# Brave (apt-transport-https ya no es necesario en Debian 13)
log "Añadiendo repositorio oficial Brave..."
install -d -m 0755 /usr/share/keyrings
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
ARCH="$(dpkg --print-architecture)"
cat >/etc/apt/sources.list.d/brave-browser-release.list <<EOF
deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=${ARCH}] https://brave-browser-apt-release.s3.brave.com/ stable main
EOF

apt-get update -y

log "Dependencias listas para Debian 13."
