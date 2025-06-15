#!/bin/sh

echo "[KindleForge] Installing kTerm (v2.6)..." #Hasn't Been Updated Since 2020, I'll Just Hardcode

if [ -f /lib/ld-linux-armhf.so.3 ]; then
  #KindleHF
  echo "Using HF!"
  curl -L -o /mnt/us/extensions/KtermHF.zip https://github.com/bfabiszewski/kterm/releases/download/v2.6/kterm-kindle-2.6-armhf.zip

  unzip /mnt/us/extensions/KtermHF.zip
  rm -f /mnt/us/extensions/KtermHF.zip
else
  #KindlePW2
  echo "Using SF!"
  curl -L -o /mnt/us/extensions/KtermSF.zip https://github.com/bfabiszewski/kterm/releases/download/v2.6/kterm-kindle-2.6.zip

  unzip /mnt/us/extensions/KtermSF.zip
  rm -f /mnt/us/extensions/KtermSF.zip
fi

echo "[KindleForge] kTerm Installation Complete."

# Packages.LIST
FILE="/var/local/mesquite/KindleForge/assets/packages.list"
STRING="kTerm"

grep -qxF "$STRING" "$FILE" || echo "$STRING" >> "$FILE"

exit 0