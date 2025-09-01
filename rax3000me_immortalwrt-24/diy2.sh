#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Mosdns
rm -rf feeds/packages/lang/golang
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/v2ray-geodata
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/package-mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
# Modify default IP
sed -i "s/192.168.1.1/192.168.5.1/g" package/base-files/files/bin/config_generate
sed -i "s/hostname='ImmortalWrt'/hostname='RAX3000Me'/g" package/base-files/files/bin/config_generate
sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION='wangdada $(date +"%y%m%d") 24.10'/g" package/base-files/files/etc/openwrt_release
