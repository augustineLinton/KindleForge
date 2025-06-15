#!/bin/sh

echo "[KindleForge] Uninstalling KOReader..."

rm -rf /mnt/us/extensions/koreader
rm -rf /mnt/us/koreader

echo "[KindleForge] KOReader Removal Complete."

#Packages.LIST
sed -i '/^KOReader$/d' /var/local/mesquite/KindleForge/assets/packages.list

exit 0