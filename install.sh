#!/bin/bash
# ─────────────────────────────────────────────
#  NEXUS AI — Plymouth Theme Installer
# ─────────────────────────────────────────────

set -e

# Resolve script directory regardless of where it's called from
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

THEME_NAME="nexus"
THEME_DIR="/usr/share/plymouth/themes/$THEME_NAME"

# Root check
if [[ $EUID -ne 0 ]]; then
    echo "Error: This script must be run as root."
    echo "Usage: sudo bash install.sh"
    exit 1
fi

echo "[ NEXUS ] Installing Plymouth theme..."

# Verify source files exist
if [[ ! -f "$SCRIPT_DIR/nexus.plymouth" ]]; then
    echo "Error: nexus.plymouth not found in $SCRIPT_DIR"
    exit 1
fi
if [[ ! -f "$SCRIPT_DIR/nexus.script" ]]; then
    echo "Error: nexus.script not found in $SCRIPT_DIR"
    exit 1
fi
if [[ ! -f "$SCRIPT_DIR/splash.png" ]]; then
    echo "Error: splash.png not found in $SCRIPT_DIR"
    echo "  Run: python3 generate_assets.py"
    exit 1
fi

# Copy theme files
mkdir -p "$THEME_DIR"
cp "$SCRIPT_DIR/nexus.plymouth"    "$THEME_DIR/"
cp "$SCRIPT_DIR/nexus.script"      "$THEME_DIR/"
cp "$SCRIPT_DIR/splash.png"        "$THEME_DIR/"
cp "$SCRIPT_DIR"/progress_*.png    "$THEME_DIR/"

echo "[ NEXUS ] Files copied to $THEME_DIR"

# Set as default theme
if update-alternatives --install \
  /usr/share/plymouth/themes/default.plymouth \
  default.plymouth \
  "$THEME_DIR/nexus.plymouth" 100; then
    update-alternatives --set \
      default.plymouth \
      "$THEME_DIR/nexus.plymouth"
    echo "[ NEXUS ] Theme set as default"
else
    echo "[ NEXUS ] Warning: Could not register theme via update-alternatives"
    echo "  You may need to run: plymouth-set-default-theme $THEME_NAME"
fi

# Rebuild initramfs
echo "[ NEXUS ] Rebuilding initramfs (this may take a moment)..."
if update-initramfs -u; then
    echo ""
    echo "✓ NEXUS Plymouth theme installed successfully!"
    echo "  Reboot to see it in action."
else
    echo ""
    echo "! NEXUS theme installed, but initramfs rebuild had issues."
    echo "  Rebuild manually: sudo update-initramfs -u"
fi
