#!/bin/sh

echo "[KindleForge] Installing KindleFetch..."

curl https://justrals.github.io/KindleFetch/install.sh | sh 

echo "[KindleForge] KindleFetch Installation Complete."

# Packages.LIST
FILE="/var/local/mesquite/KindleForge/assets/packages.list"
STRING="KindleFetch"

grep -qxF "$STRING" "$FILE" || echo "$STRING" >> "$FILE"

exit 0