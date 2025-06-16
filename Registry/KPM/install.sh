#!/bin/sh

echo "[KindleForge] Installing KPM..."

curl https://raw.githubusercontent.com/gingrspacecadet/kpm/main/install-kpm.sh | sh 

echo "[KindleForge] KPM Installation Complete."

# Packages.LIST
FILE="/var/local/mesquite/KindleForge/assets/packages.list"
STRING="KPM"

grep -qxF "$STRING" "$FILE" || echo "$STRING" >> "$FILE"

exit 0