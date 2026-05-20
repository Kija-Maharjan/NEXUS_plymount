# NEXUS_plymount

NEXUS AI Plymouth boot splash theme with animated logo and progress bar.

## Installation

```bash
sudo bash install.sh
```

## Requirements

- Plymouth installed on your system
- Root privileges for installation

## Uninstall

```bash
sudo rm -rf /usr/share/plymouth/themes/nexus
sudo update-alternatives --remove default.plymouth /usr/share/plymouth/themes/nexus/nexus.plymouth
sudo update-initramfs -u
```

## Preview

```bash
sudo plymouthd
sudo plymouth --show-splash
sleep 5
sudo plymouth quit
```