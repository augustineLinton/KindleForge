#!/bin/sh

set -e
echo "[KindleForge] Installing KWordle..."

mkdir -p /mnt/us/kforge
curl -L -o /mnt/us/kforge/kwordle.zip https://github.com/crizmo/kwordle/releases/download/v1.2.0/kwordle.zip 
unzip -q /mnt/us/kforge/kwordle.zip -d /mnt/us/kforge
mkdir -p /mnt/us/documents/kwordle
cp -r /mnt/us/kforge/kwordle/* /mnt/us/documents/kwordle/
cp /mnt/us/kforge/kwordle.sh /mnt/us/documents/
chmod +x /mnt/us/documents/kwordle.sh

rm -rf /mnt/us/kforge

echo "[KindleForge] KWordle Installation Complete."

# Packages.LIST
FILE="/var/local/mesquite/KindleForge/assets/packages.list"
STRING="KWordle"

grep -qxF "$STRING" "$FILE" || echo "$STRING" >> "$FILE"

exit 0