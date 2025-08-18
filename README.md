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
  - Entrada de GRUB personalizada

---

## 📦 Sobre Debian 13 (Trixie)

Hadassa OS está construida sobre **Debian 13 “Trixie”**, próxima versión estable de Debian, con fecha de lanzamiento prevista para **2025**.

Algunas características destacadas de Debian 13:

- Basado en **Linux Kernel 6.x**, con mejoras de rendimiento, seguridad y soporte de hardware más moderno.  
- Repositorios actualizados con versiones más recientes de software como **KDE Plasma 6, GNOME 46, LibreOffice 24.x, GCC 14**, entre otros.  
- Continuación del compromiso de Debian con la **estabilidad y seguridad** a largo plazo (LTS).  
- Compatibilidad con **Wayland** como servidor gráfico recomendado.  
- Arquitecturas soportadas: amd64, arm64, armhf, i386, mips64el, ppc64el, s390x.  
- Soporte previsto de actualizaciones de seguridad hasta al menos **2030** (con LTS).

👉 Hadassa OS hereda toda la robustez y estabilidad de Debian, pero orientada a un público hispanohablante y con una experiencia de usuario lista desde la primera instalación.

---

## 📥 Instalación

1. Instala Debian 13 (Trixie) desde **Netinstall**.
2. Descarga el script desde GitHub con **wget** o **curl**:

```bash
wget https://raw.githubusercontent.com/Nathanaelrc/Hadassas-OS/main/install.txt -O postinstall.sh
