# NEXUS_plymount

NEXUS AI Plymouth boot splash theme — animated throbber + progress bar, pure black background, no Debian branding.

## Installation

```bash
sudo bash install.sh
```

## Requirements

- Plymouth (Debian package `plymouth`, `plymouth-themes`)
- `desktop-base` package (for the watermark override fix)
- Root privileges

## What `install.sh` does

1. Copies theme files to `/usr/share/plymouth/themes/nexus/`
2. Replaces `/usr/share/plymouth/debian-logo.png` with a transparent placeholder
3. Replaces `/usr/share/desktop-base/debian-logos/logo-text-version-64.png` with a transparent placeholder — **this is essential** because Debian's initramfs hook (`/usr/share/initramfs-tools/hooks/plymouth`) copies this file as `watermark.png` for any theme using `ModuleName=two-step`
4. Sets the default theme to `nexus`
5. Rebuilds the initramfs

## Uninstall

```bash
sudo rm -rf /usr/share/plymouth/themes/nexus
sudo update-alternatives --remove default.plymouth /usr/share/plymouth/themes/nexus/nexus.plymouth
sudo update-initramfs -u
```

To restore Debian branding:

```bash
sudo cp /usr/share/plymouth/debian-logo.png.backup \
     /usr/share/plymouth/debian-logo.png
sudo cp /usr/share/desktop-base/debian-logos/logo-text-version-64.png.backup \
     /usr/share/desktop-base/debian-logos/logo-text-version-64.png
```

## Preview

```bash
sudo plymouthd
sudo plymouth --show-splash
sleep 5
sudo plymouth --quit
```