#!/bin/sh

set -e
echo "[KindleForge] Uninstalling KWordle..."

rm -rf /mnt/us/documents/kwordle/
rm -f /mnt/us/documents/kwordle.sh

echo "[KindleForge] KWordle Removal Complete."

#Packages.LIST
sed -i '/^KWordle$/d' /var/local/mesquite/KindleForge/assets/packages.list

exit 0