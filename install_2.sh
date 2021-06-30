#!/bin/bash

#set -x

INSTALL_DIR="./mydata/app_data/custom_apps"
if [ ! -d ${INSTALL_DIR} ];then
    echo "install_1的脚本还没安装完成吧，别心急，等待..."
    exit 0
fi
echo "开始解压玩儿熊准备的插件包apps.tar.gz进行安装啦..."
sleep 2
tar vxzf apps.tar.gz&&cp -rf ./apps/* ${INSTALL_DIR} && chown -R www-data ${INSTALL_DIR}
rm -rf apps
echo "所有APP已经安装完毕，现在设置onlyoffice的访问..."
echo "正在设置信用的访问内部网络的IP地址..."
docker exec -u www-data nextcloud-server php occ --no-warnings config:system:get trusted_domains >> trusted_domain.tmp
if ! grep -q "nginx-server" trusted_domain.tmp; then
    TRUSTED_INDEX=$(cat trusted_domain.tmp | wc -l);
    docker exec -u www-data nextcloud-server php occ --no-warnings config:system:set trusted_domains $TRUSTED_INDEX --value="nginx-server"
fi
rm trusted_domain.tmp
echo "正在安装onlyoffice和相关设置，其他自定义设置请到平台的设置菜单上..."
docker exec -u www-data nextcloud-server php occ --no-warnings app:install onlyoffice
docker exec -u www-data nextcloud-server php occ --no-warnings app:enable onlyoffice
docker exec -u www-data nextcloud-server php occ --no-warnings config:system:set onlyoffice DocumentServerUrl --value="/ds-vpath/"
docker exec -u www-data nextcloud-server php occ --no-warnings config:system:set onlyoffice DocumentServerInternalUrl --value="http://onlyoffice-document-server/"
docker exec -u www-data nextcloud-server php occ --no-warnings config:system:set onlyoffice StorageUrl --value="http://nginx-server/"
docker exec -u www-data nextcloud-server php occ --no-warnings config:system:set allow_local_remote_servers  --value=true

echo "onlyoffice也已经设置成功，可以直接访问office三件套啦！！！"
echo "准备的APP已经安装完毕，赶紧打开网页启用插件吧!!"