#!/bin/bash
# ─────────────────────────────────────────────
#  NEXUS AI — Plymouth Theme Installer
# ─────────────────────────────────────────────

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="nexus"
THEME_DIR="/usr/share/plymouth/themes/$THEME_NAME"

if [[ $EUID -ne 0 ]]; then
    echo "Error: Run as root: sudo bash install.sh"
    exit 1
fi

echo "[ NEXUS ] Installing Plymouth theme..."
mkdir -p "$THEME_DIR"

# Copy all theme files
cp "$SCRIPT_DIR/nexus.plymouth"      "$THEME_DIR/"
cp "$SCRIPT_DIR/nexus.script"        "$THEME_DIR/"
cp "$SCRIPT_DIR/splash.png"          "$THEME_DIR/"
cp "$SCRIPT_DIR/watermark.png"       "$THEME_DIR/"
cp "$SCRIPT_DIR/bullet.png"          "$THEME_DIR/"
cp "$SCRIPT_DIR/capslock.png"        "$THEME_DIR/"
cp "$SCRIPT_DIR/entry.png"           "$THEME_DIR/"
cp "$SCRIPT_DIR/keyboard.png"        "$THEME_DIR/"
cp "$SCRIPT_DIR/keymap-render.png"   "$THEME_DIR/"
cp "$SCRIPT_DIR/lock.png"            "$THEME_DIR/"
cp "$SCRIPT_DIR"/progress_*.png      "$THEME_DIR/" 2>/dev/null || true

# Replace debian logo with transparent placeholder
if [[ -f "/usr/share/plymouth/debian-logo.png" ]]; then
    cp /usr/share/plymouth/debian-logo.png /usr/share/plymouth/debian-logo.png.backup
    echo "[ NEXUS ] Backed up debian-logo.png"
fi
cp "$SCRIPT_DIR/debian-logo.png" /usr/share/plymouth/debian-logo.png
echo "[ NEXUS ] Replaced debian-logo.png (transparent)"

# Prevent Debian initramfs hook from overriding watermark.png
# (the hook copies this file as watermark.png for two-step themes)
LOGO_VERSION="/usr/share/desktop-base/debian-logos/logo-text-version-64.png"
if [[ -f "$LOGO_VERSION" ]]; then
    cp "$LOGO_VERSION" "$LOGO_VERSION.backup"
    echo "[ NEXUS ] Backed up desktop-base logo"
fi
cp "$SCRIPT_DIR/debian-logo-text-version-64.png" "$LOGO_VERSION"
echo "[ NEXUS ] Replaced desktop-base logo (transparent — prevents watermark override)"

echo "[ NEXUS ] Files copied to $THEME_DIR"

# Set as default
plymouth-set-default-theme nexus
echo "[ NEXUS ] Theme set to nexus"

# Rebuild initramfs
echo "[ NEXUS ] Rebuilding initramfs..."
update-initramfs -u

echo ""
echo "✓ NEXUS Plymouth installed!"
echo ""
echo "  Run:  sudo reboot"
echo ""
echo "  To restore Debian branding later:"
echo "  sudo cp /usr/share/plymouth/debian-logo.png.backup      /usr/share/plymouth/debian-logo.png"
echo "  sudo cp /usr/share/desktop-base/debian-logos/logo-text-version-64.png.backup \\"
echo "       /usr/share/desktop-base/debian-logos/logo-text-version-64.png"
