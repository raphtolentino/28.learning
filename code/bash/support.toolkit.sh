#!/bin/bash

echo "===== SYSTEM DIAGNOSTIC TOOLKIT ====="
echo "[1] Disk usage:"
df -h

echo "[2] Top processes:"
ps aux --sort=-%mem | head -n 10

echo "[3] IP Information:"
ip a

echo "[4] Failed Services:"
systemctl --failed

echo "[5] External Ping Test (Cloudflare DNS):"
ping -c 4 1.1.1.1
