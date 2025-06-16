#!/bin/sh

echo "[KindleForge] Uninstalling GnomeGames..."

rm -fr /mnt/us/extensions/GnomeGames
rm /mnt/us/documents/shortcut_gnomechess.sh
rm /mnt/us/documents/shortcut_gnomine.sh

echo "[KindleForge] GnomeGames Removal Complete."

#Packages.LIST
sed -i '/^GnomeGames$/d' /var/local/mesquite/KindleForge/assets/packages.list

exit 0