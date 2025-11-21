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
git clone https://github.com/nikkinikki-org/OpenWrt-momo.git package/momo
# Modify default IP
sed -i "s/192.168.1.1/192.168.5.1/g" package/base-files/files/bin/config_generate
sed -i "s/hostname='ImmortalWrt'/hostname='RAX3000Me'/g" package/base-files/files/bin/config_generate
sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION='wangdada $(date +"%y%m%d") 24.10'/g" package/base-files/files/etc/openwrt_release
# --- 网络栈优化脚本 (添加到 diy2.sh 末尾) ---
cat <<EOF >> package/base-files/files/etc/sysctl.conf
# 提高全连接队列长度，防丢包
net.core.somaxconn = 65535
# 开启 BBR (配合 TurboACC)
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr
# 缩短 TCP Keepalive 时间，快速释放死连接
net.ipv4.tcp_keepalive_time = 600
net.ipv4.tcp_keepalive_intvl = 30
net.ipv4.tcp_keepalive_probes = 5
# 扩大文件描述符限制 (对 BT/P2P 有用)
fs.file-max = 1000000
EOF
