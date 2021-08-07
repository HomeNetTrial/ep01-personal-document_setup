#!/bin/bash
#set -x
sudo apt-get -y install docker.io docker-compose
sudo systemctl enable docker
sudo service docker restart
sudo gpasswd -a ${USER} docker
echo "开始启动nextcloud服务咯，坐稳！！！"
sudo docker-compose up -d
echo "小助手🐷正在安装中，等待3分钟-20分钟不等，尝试打开网页进行程序安装哦...地址是： http://你的IP地址:8088"
echo "时不时刷新一下这个地址：http://你的IP地址:8088，看看是否到了登录的界面"
exit 0