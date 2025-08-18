# Hadassas-OS
Sistema operativo basado en debian 13 "Trixie"

# 🇨🇱 Hadassa OS

**Hadassa OS** es un proyecto de distribución GNU/Linux basada en **Debian 13 (Trixie)**, desarrollada en Chile 🇨🇱.  
Su propósito es entregar un sistema operativo **moderno, en español, con entorno KDE Plasma y herramientas listas para uso cotidiano y profesional**.

---

## ✨ Características principales

- **Origen chileno**: pensada para usuarios hispanohablantes, con idioma y teclado configurados por defecto a español latinoamericano.  
- **Entorno gráfico KDE Plasma** con **Wayland** como servidor gráfico por defecto.  
- **Ofimática completa**: LibreOffice en español.  
- **Navegación segura**: Brave Browser desde el repositorio oficial.  
- **Herramientas del sistema**:
  - Synaptic (gestor de paquetes gráfico)
  - FileZilla (cliente FTP)
  - Remmina (RDP/VNC)
  - VLC (multimedia)
  - htop y btop (monitoreo de sistema)  
- **Usuarios preconfigurados**:
  - `root` con contraseña `root`
  - `live` con contraseña `live` (incluido en grupo `sudo`)  
- **Personalización**:
  - Hostname configurado como `hadassa-os`
  - Mensajes de bienvenida con marca **Hadassa OS**
  - Entrada de GRUB personalizada

---

## 📥 Instalación

1. Instala Debian 13 (Trixie) desde **Netinstall**.
2. Descarga el script desde GitHub con **wget** o **curl**:

```bash
wget https://raw.githubusercontent.com/Nathanaelrc/Hadassas-OS/main/install.txt -O postinstall.sh
