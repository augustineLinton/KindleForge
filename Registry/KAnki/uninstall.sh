#!/bin/sh

set -e
echo "[KindleForge] Uninstalling KAnki..."

rm -rf /mnt/us/documents/kanki/
rm -f /mnt/us/documents/kanki.sh

echo "[KindleForge] KAnki Removal Complete."

#Packages.LIST
sed -i '/^KAnki$/d' /var/local/mesquite/KindleForge/assets/packages.list

exit 0