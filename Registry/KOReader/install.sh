#!/bin/sh

set -e
echo "[KindleForge] Installing KOReader..."

# Script Credit Goes To MAREK!
OTA_SERVER="https://ota.koreader.rocks/"
CHANNEL="nightly"
OTA_ZSYNC="koreader-kindlehf-latest-$CHANNEL.zsync"

if [ -f /lib/ld-linux-armhf.so.3 ]; then
  #KindleHF
  echo "Using KindleHF!"
else
  #KindlePW2
  echo "Using KindlePW2!"
  OTA_ZSYNC="koreader-kindlepw2-latest-$CHANNEL.zsync"
fi

OTA_FILENAME=$(curl "$OTA_SERVER$OTA_ZSYNC" -s -r 0-150 | grep Filename | sed 's/Filename: //')

if [ "$OTA_FILENAME" = "" ]; then
  echo "Release Not Found!"
  exit 1
fi

curl $OTA_SERVER$OTA_FILENAME -s --output /tmp/KOReaderInstall.tar.gz
tar -xf /tmp/KOReaderInstall.tar.gz -C /mnt/us/

echo "[KindleForge] KOReader Installation Complete."

# Packages.LIST
FILE="/var/local/mesquite/KindleForge/assets/packages.list"
STRING="KOReader"

grep -qxF "$STRING" "$FILE" || echo "$STRING" >> "$FILE"

exit 0

