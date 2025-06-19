#!/bin/sh

set -e
echo "[KindleForge] Uninstalling KindleKraft..."

rm -rf /mnt/us/extensions/KKraft
rm -f /mnt/us/kindlekraft-1.0.0.tar.gz

echo "[KindleForge] KindleKraft Removal Complete."

#Packages.LIST
sed -i '/^KindleKraft$/d' /var/local/mesquite/KindleForge/assets/packages.list

exit 0