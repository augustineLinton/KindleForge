#!/bin/sh

echo "[KindleForge] Installing GnomeGames..."

# Download + Extract
mkdir -p /mnt/us/kforge
curl -L -o /mnt/us/kforge/GnomeGames.zip https://github.com/crazy-electron/GnomeGames4Kindle/releases/latest/download/gnomegames.zip 
unzip -q /mnt/us/kforge/GnomeGames.zip -d /mnt/us/kforge/
mkdir -p /mnt/us/extensions/GnomeGames
cp -r /mnt/us/kforge/GnomeGames/* /mnt/us/extensions/GnomeGames

# Scriptlets
cp /mnt/us/extensions/GnomeGames/shortcut_gnomechess.sh /mnt/us/documents
cp /mnt/us/extensions/GnomeGames/shortcut_gnomine.sh /mnt/us/documents

rm -rf /mnt/us/kforge

echo "[KindleForge] GnomeGames Installation Complete."

# Packages.LIST
FILE="/var/local/mesquite/KindleForge/assets/packages.list"
STRING="GnomeGames"

grep -qxF "$STRING" "$FILE" || echo "$STRING" >> "$FILE"

exit 0
