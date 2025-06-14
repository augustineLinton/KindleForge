#!/bin/sh
# Name: KindleForge
# Author: Penguins
# DontUseFBInk

# IllusionUtild v2

SOURCE_DIR="/mnt/us/documents/KindleForge"
TARGET_DIR="/var/local/mesquite/KindleForge"
DB="/var/local/appreg.db"
APP_ID="xyz.penguins184.kindleforge"

#DO NOT MODIFY BELOW

#Copy UTILD Binaries To VAR/LOCAL/KMC
BINARY="$SOURCE_DIR/.illusion/UtildSF"
[ -e /lib/ld-linux-armhf.so.3 ] && BINARY="$SOURCE_DIR/.illusion/UtildHF"

[ -e "$BINARY" ] && cp "$BINARY" /var/local/kmc && rm "$BINARY"

#Run UTILD
if [ -e /lib/ld-linux-armhf.so.3 ]; then
    rm -f /var/local/kmc/UtildSF

    chmod +x /var/local/kmc/UtildHF
    /var/local/kmc/UtildHF
else
    rm -f /var/local/kmc/UtildHF

    chmod +x /var/local/kmc/UtildSF
    /var/local/kmc/UtildSF
fi

#Install KPM 
if [ ! -x /usr/local/bin/kpm ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/gingrspacecadet/kpm/main/install-kpm.sh)"
  if [ $? -ne 0 ]; then
    echo "Failed To Install KPM! Please Check Your Internet Connection."
    exit 1
  fi
fi

#Copy To VAR/LOCAL/MESQUITE
if [ -d "$SOURCE_DIR" ]; then
    if [ -d "$TARGET_DIR" ]; then
        rm -rf "$TARGET_DIR"
    fi
    cp -r "$SOURCE_DIR" "$TARGET_DIR"
else
    exit 1
fi

#Redeclare To APPREG.DB 
sqlite3 "$DB" <<EOF
INSERT OR IGNORE INTO interfaces(interface) VALUES('application');

INSERT OR IGNORE INTO handlerIds(handlerId) VALUES('$APP_ID');

INSERT OR REPLACE INTO properties(handlerId,name,value) 
  VALUES('$APP_ID','lipcId','$APP_ID');
INSERT OR REPLACE INTO properties(handlerId,name,value) 
  VALUES('$APP_ID','command','/usr/bin/mesquite -l $APP_ID -c file://$TARGET_DIR/');
INSERT OR REPLACE INTO properties(handlerId,name,value) 
  VALUES('$APP_ID','supportedOrientation','U');
EOF

echo Registered $APP_ID, You May Now Launch It With LIPC.
sleep 2

#Launch With LIPC
nohup lipc-set-prop com.lab126.appmgrd start app://$APP_ID >/dev/null 2>&1 &