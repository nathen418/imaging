#!/bin/bash
set -e

echo "[*] Configuring login banner..."

BANNER_FILE="/etc/issue.net"

sudo tee "$BANNER_FILE" > /dev/null <<'EOF'
*************************************************************************************************************
*                                                                                                           *
*   You are attempting to login to a restricted system. Access to internal and network resources is closely *
*   monitored.                                                                                              *
*                                                                                                           *
*   Unauthorized or spam login attempts will result in punitive action. Authorized users only.              *
*                                                                                                           *
*   If you are not authorized, LOG OUT IMMEDIATELY.                                                         *
*                                                                                                           *
*************************************************************************************************************
EOF

if sudo grep -q "^Banner" /etc/ssh/sshd_config; then
    sudo sed -i "s|^Banner.*|Banner $BANNER_FILE|" /etc/ssh/sshd_config
else
    echo "Banner $BANNER_FILE" | sudo tee -a /etc/ssh/sshd_config > /dev/null
fi

echo "[*] Disabling stock Ubuntu MOTD messages..."

DISABLE_MOTD=(
  00-header
  10-help-text
  50-motd-news
  80-livepatch
  80-esm
  80-ubuntu-advantage
  91-contract-ua-esm-status
  97-overlayroot
  98-cloudguest
  98-fsck-at-reboot
  98-reboot-required
  99-kubernetes
)

for script in "${DISABLE_MOTD[@]}"; do
    if [ -f "/etc/update-motd.d/$script" ]; then
        sudo chmod -x "/etc/update-motd.d/$script"
    fi
done

sudo systemctl restart ssh || true

echo "[+] Banner configured."
