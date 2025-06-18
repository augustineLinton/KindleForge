#!/bin/sh

set -e
echo "[KindleForge] Uninstalling KindleFetch..."

rm -rf /mnt/us/extensions/kindlefetch
# Configuration Files Are Kept!

echo "[KindleForge] KindleFetch Removal Complete."

#Packages.LIST
sed -i '/^KindleFetch$/d' /var/local/mesquite/KindleForge/assets/packages.list

exit 0