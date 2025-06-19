#!/bin/sh

set -e
echo "[KindleForge] Installing KindleKraft..."

mkdir -p /mnt/us/kforge
mkdir -p /mnt/us/extensions/KKraft
curl -L -o /mnt/us/kindlekraft-1.0.0.tar.gz https://github.com/polish-penguin-dev/KindleKraft/releases/download/v1.0.0/kindlekraft-1.0.0.tar.gz #Root Archive
curl -L -o /mnt/us/kforge/kindlekraft-extension.zip https://github.com/polish-penguin-dev/KindleKraft/releases/download/v1.0.0/kindlekraft-extension.zip #Extension
unzip -q /mnt/us/kforge/kindlekraft-extension.zip -d /mnt/us/kforge
cp /mnt/us/kforge/KKraft/* /mnt/us/extensions/KKraft

rm -rf /mnt/us/kforge

echo "[KindleForge] KindleKraft Installation Complete."

# Packages.LIST
FILE="/var/local/mesquite/KindleForge/assets/packages.list"
STRING="KindleKraft"

grep -qxF "$STRING" "$FILE" || echo "$STRING" >> "$FILE"

exit 0

