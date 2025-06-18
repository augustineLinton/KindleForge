#!/bin/sh

echo "[KindleForge] Uninstalling GambatteK2..."

rm -fr /mnt/us/extensions/GambatteK2
rm /mnt/us/documents/shortcut_gambatte-k2.sh

echo "[KindleForge] GambatteK2 Removal Complete."

#Packages.LIST
sed -i '/^GambatteK2$/d' /var/local/mesquite/KindleForge/assets/packages.list

exit 0