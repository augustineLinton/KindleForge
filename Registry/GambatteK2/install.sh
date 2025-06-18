#!/bin/sh

echo "[KindleForge] Installing GambatteK2..."

# Download + Extract
mkdir -p /mnt/us/kforge
curl -L -o /mnt/us/kforge/GambatteK2.zip https://github.com/crazy-electron/gambatte-k2/releases/latest/download/gambatte-k2.zip
unzip -q /mnt/us/kforge/GambatteK2.zip -d /mnt/us/kforge/
mkdir -p /mnt/us/extensions/gambatte-k2
cp -r /mnt/us/kforge/gambatte-k2/* /mnt/us/extensions/gambatte-k2

# Scriptlets
cp /mnt/us/extensions/gambatte-k2/shortcut_gambatte-k2.sh /mnt/us/documents

rm -rf /mnt/us/kforge

echo "[KindleForge] GambatteK2 Installation Complete."

# Packages.LIST
FILE="/var/local/mesquite/KindleForge/assets/packages.list"
STRING="GambatteK2"

grep -qxF "$STRING" "$FILE" || echo "$STRING" >> "$FILE"

exit 0
