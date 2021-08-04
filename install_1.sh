#!/bin/bash
#set -x
sudo apt-get -y install docker.io docker-compose
sudo service docker restart
echo "开始启动nextcloud服务咯，坐稳！！！"
docker-compose up -d
echo "小助手🐷正在安装中，等待30秒后，尝试打开网页进行程序安装哦...地址是： http://你的IP地址:8088"
exit 0