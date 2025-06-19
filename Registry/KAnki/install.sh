#!/bin/sh

set -e
echo "[KindleForge] Installing KAnki..."

mkdir -p /mnt/us/kforge
curl -L -o /mnt/us/kforge/kanki.zip https://github.com/crizmo/KAnki/releases/download/v1.1.0/kanki.zip
unzip -q /mnt/us/kforge/kanki.zip -d /mnt/us/kforge
mkdir -p /mnt/us/documents/kanki
cp -r /mnt/us/kforge/kanki/* /mnt/us/documents/kanki/
cp /mnt/us/kforge/kanki.sh /mnt/us/documents/
chmod +x /mnt/us/documents/kanki.sh

rm -rf /mnt/us/kforge

echo "[KindleForge] KAnki Installation Complete."

# Packages.LIST
FILE="/var/local/mesquite/KindleForge/assets/packages.list"
STRING="KAnki"

grep -qxF "$STRING" "$FILE" || echo "$STRING" >> "$FILE"

exit 0