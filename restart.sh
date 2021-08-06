#!/bin/bash
#set -x
echo "正在启动你的尊贵的nextcloud服务咯..."
chmod +x *.sh
./stop.sh
docker-compose up -d