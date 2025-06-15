#!/bin/sh

echo "[KindleForge] Uninstalling kTerm..."

rm -rf /mnt/us/extensions/kterm

echo "[KindleForge] kTerm Removal Complete."

#Packages.LIST
sed -i '/^kTerm$/d' /var/local/mesquite/KindleForge/assets/packages.list

exit 0