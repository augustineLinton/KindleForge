#!/bin/sh

echo "[KindleForge] Uninstalling KPM..."

mntroot rw
rm -f /usr/local/bin/kpm
rm -rf /mnt/us/kpm
mntroot ro

# Configuration Files Are Kept! (/etc)

echo "[KindleForge] KPM Removal Complete."

#Packages.LIST
sed -i '/^KPM$/d' /var/local/mesquite/KindleForge/assets/packages.list

exit 0