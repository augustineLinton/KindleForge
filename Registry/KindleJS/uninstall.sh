#!/bin/sh

set -e
echo "[KindleForge] Uninstalling KindleJS..."

mntroot rw
rm -f /usr/bin/kindlejs
mntroot ro

echo "[KindleForge] KindleJS Removal Complete."

#Packages.LIST
sed -i '/^KindleJS$/d' /var/local/mesquite/KindleForge/assets/packages.list

exit 0