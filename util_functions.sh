# shellcheck disable=SC2148
patch_device_features() {
  DEVICE_CODE="$(getprop ro.product.device)"
  SYSTEM_DEVICE_FEATURES_PATH=/system/product/etc/device_features/${DEVICE_CODE}.xml
  MODULE_DEVICE_FEATURES_PATH="$1"/system/product/etc/device_features/${DEVICE_CODE}.xml

  # 移除旧版补丁文件
  rm -rf "$MODULE_DEVICE_FEATURES_PATH"

  # 复制私有App权限配置到模块内
  cp -f "$SYSTEM_DEVICE_FEATURES_PATH" "$MODULE_DEVICE_FEATURES_PATH"

  # 拷贝权限代码片段到模块文件内
  if [[ -f "$MODULE_DEVICE_FEATURES_PATH" ]]; then
    sed -i 's/<bool name="remove_screen_off_hold_on">true<\/bool>/<bool name="remove_screen_off_hold_on">false<\/bool>/g' $MODULE_DEVICE_FEATURES_PATH
  fi
}