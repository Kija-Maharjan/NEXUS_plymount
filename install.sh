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
cp "$SCRIPT_DIR/nexus.plymouth"     "$THEME_DIR/"
cp "$SCRIPT_DIR/nexus.script"       "$THEME_DIR/"
cp "$SCRIPT_DIR/splash.png"         "$THEME_DIR/"
cp "$SCRIPT_DIR"/throbber-*.png     "$THEME_DIR/"
cp "$SCRIPT_DIR/bullet.png"         "$THEME_DIR/"
cp "$SCRIPT_DIR/entry.png"          "$THEME_DIR/"
cp "$SCRIPT_DIR/lock.png"           "$THEME_DIR/"
cp "$SCRIPT_DIR/keyboard.png"       "$THEME_DIR/"
cp "$SCRIPT_DIR/capslock.png"       "$THEME_DIR/"
cp "$SCRIPT_DIR/keymap-render.png"  "$THEME_DIR/"

echo "[ NEXUS ] Files copied to $THEME_DIR"

plymouth-set-default-theme nexus
echo "[ NEXUS ] Theme set to nexus"

echo "[ NEXUS ] Rebuilding initramfs..."
update-initramfs -u

echo ""
echo "✓ NEXUS Plymouth installed! Run: sudo reboot"
