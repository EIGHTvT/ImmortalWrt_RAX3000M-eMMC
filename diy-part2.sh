#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# 进入驱动目录
target_dir="target/linux/mediatek/files-6.6/drivers/net/ethernet/mediatek"

# 强行在 mtk_eth_soc.c 开头插入缺失的宏定义
if [ -f "$target_dir/mtk_eth_soc.c" ]; then
    sed -i '1i #define HIT_BIND_FORCE_TO_CPU 0x8' "$target_dir/mtk_eth_soc.c"
    sed -i '1i #define MTK_FE_START_RESET 0x10' "$target_dir/mtk_eth_soc.c"
    sed -i '1i #define MTK_FE_RESET_DONE 0x11' "$target_dir/mtk_eth_soc.c"
    sed -i '1i #define MTK_FE_RESET_NAT_DONE 0x12' "$target_dir/mtk_eth_soc.c"
    sed -i '1i #define MTK_WIFI_RESET_DONE 0x13' "$target_dir/mtk_eth_soc.c"
    sed -i '1i #define MTK_WIFI_CHIP_ONLINE 0x14' "$target_dir/mtk_eth_soc.c"
    sed -i '1i #define MTK_WIFI_CHIP_OFFLINE 0x15' "$target_dir/mtk_eth_soc.c"
fi
