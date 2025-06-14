#!/bin/sh
# Name: KindleForge
# Author: Penguins
# UseHooks
# DontUseFBInk

# IllusionUtild v2

SOURCE_DIR="/mnt/us/documents/KindleForge"
TARGET_DIR="/var/local/mesquite/KindleForge"
DB="/var/local/appreg.db"
APP_ID="xyz.penguins184.kindleforge"

on_install() {
    B="$SOURCE_DIR/.illusion"; U="/var/local/kmc"
    [ -e /lib/ld-linux-armhf.so.3 ] && X=UtildHF || X=UtildSF
    [ -e "$B/$X" ] && cp "$B/$X" "$U" && rm "$B/$X"
    chmod +x "$U/$X"; rm -f "$B/${X/UtildHF/UtildSF}" "$B/${X/UtildSF/UtildHF}"

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/gingrspacecadet/kpm/main/install-kpm.sh)"

    if [ -d "$SOURCE_DIR" ]; then
      if [ -d "$TARGET_DIR" ]; then
        rm -rf "$TARGET_DIR"
      fi
      cp -r "$SOURCE_DIR" "$TARGET_DIR"
    else
      exit 1
    fi

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
    eips 1 25 'KindleForge May Now Be Launched!'
}

on_remove() {
    rm -rf "$TARGET_DIR"
    sqlite3 "$DB" <<EOF
DELETE FROM properties WHERE handlerId='$APP_ID';
DELETE FROM handlerIds WHERE handlerId='$APP_ID';
EOF
    rm -f /var/local/kmc/UtildHF /var/local/kmc/UtildSF
    rm -f /usr/local/bin/kpm
    rm -rf "$SOURCE_DIR"

    eips 1 25 'KindleForge Removed Successfully!'
}

on_run() {
    sleep 2
    nohup lipc-set-prop com.lab126.appmgrd start app://$APP_ID >/dev/null 2>&1 &
}
