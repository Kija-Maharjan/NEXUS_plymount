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

# Check required files
for f in nexus.plymouth nexus.script splash.png watermark.png; do
    if [[ ! -f "$SCRIPT_DIR/$f" ]]; then
        echo "Error: $f not found. Run: python3 generate_assets.py"
        exit 1
    fi
done

echo "[ NEXUS ] Installing Plymouth theme..."
mkdir -p "$THEME_DIR"

# Copy all theme files
cp "$SCRIPT_DIR/nexus.plymouth"  "$THEME_DIR/"
cp "$SCRIPT_DIR/nexus.script"    "$THEME_DIR/"
cp "$SCRIPT_DIR/splash.png"      "$THEME_DIR/"
cp "$SCRIPT_DIR/watermark.png"   "$THEME_DIR/"
cp "$SCRIPT_DIR"/throbber-*.png  "$THEME_DIR/"

echo "[ NEXUS ] Files copied to $THEME_DIR"

# Set as default
plymouth-set-default-theme nexus
echo "[ NEXUS ] Theme set to nexus"

# Rebuild initramfs
echo "[ NEXUS ] Rebuilding initramfs..."
update-initramfs -u

echo ""
echo "✓ NEXUS Plymouth installed! Run: sudo reboot"
