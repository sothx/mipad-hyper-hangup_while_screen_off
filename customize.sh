# shellcheck disable=SC2148
# shellcheck disable=SC2034
SKIPUNZIP=0
. "$MODPATH"/util_functions.sh
DEVICE_CODE="$(getprop ro.product.device)"
SYSTEM_DEVICE_FEATURES_PATH=/system/product/etc/device_features/${DEVICE_CODE}.xml

if [[ "$KSU" == "true" ]]; then
  ui_print "- KernelSU 用户空间当前的版本号: $KSU_VER_CODE"
  ui_print "- KernelSU 内核空间当前的版本号: $KSU_KERNEL_VER_CODE"
else
  ui_print "- Magisk 版本: $MAGISK_VER_CODE"
  if [ "$MAGISK_VER_CODE" -lt 26000 ]; then
    ui_print "*********************************************"
    ui_print "! 请安装 Magisk 26.0+"
    abort "*********************************************"
  fi
fi

if [[ ! -f "$SYSTEM_DEVICE_FEATURES_PATH" ]]; then
  abort "安装失败，没有查找到合适的设备配置文件！"
fi



ui_print "- 正在为你修补熄屏挂机/熄屏听剧，请稍等~"
patch_device_features "$MODPATH"


ui_print "- 好诶，《HyperOS For Pad 熄屏挂机及熄屏听剧补全补丁》安装/更新完成，重启系统后生效！"
