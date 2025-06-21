#!/bin/sh

set -e
echo "[KindleForge] Installing KindleJS..."

mntroot rw
curl -L -o /usr/bin/kindlejs https://github.com/polish-penguin-dev/KindleForge/raw/refs/heads/master/Registry/KindleJS/kindlejs
chmod +x /usr/bin/kindlejs
mntroot ro

echo "[KindleForge] KindleJS Installation Complete."

# Packages.LIST
FILE="/var/local/mesquite/KindleForge/assets/packages.list"
STRING="KindleJS"

grep -qxF "$STRING" "$FILE" || echo "$STRING" >> "$FILE"

exit 0