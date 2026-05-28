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

# Copy theme files
cp "$SCRIPT_DIR/nexus.plymouth"  "$THEME_DIR/"
cp "$SCRIPT_DIR/nexus.script"    "$THEME_DIR/"
cp "$SCRIPT_DIR/splash.png"      "$THEME_DIR/"
cp "$SCRIPT_DIR/watermark.png"   "$THEME_DIR/"
cp "$SCRIPT_DIR"/throbber-*.png  "$THEME_DIR/"

# Replace debian logo with NEXUS logo
if [[ -f "/usr/share/plymouth/debian-logo.png" ]]; then
    cp /usr/share/plymouth/debian-logo.png /usr/share/plymouth/debian-logo.png.backup
    echo "[ NEXUS ] Backed up debian-logo.png"
fi
cp "$SCRIPT_DIR/debian-logo.png" /usr/share/plymouth/debian-logo.png
echo "[ NEXUS ] Replaced debian logo with NEXUS logo"

echo "[ NEXUS ] Files copied to $THEME_DIR"

# Set as default
plymouth-set-default-theme nexus
echo "[ NEXUS ] Theme set to nexus"

# Rebuild initramfs
echo "[ NEXUS ] Rebuilding initramfs..."
update-initramfs -u

echo ""
echo "✓ NEXUS Plymouth installed! Run: sudo reboot"
echo ""
echo "  To restore Debian logo later:"
echo "  sudo cp /usr/share/plymouth/debian-logo.png.backup /usr/share/plymouth/debian-logo.png"
