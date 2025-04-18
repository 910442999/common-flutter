import 'dart:io';

import 'package:flutter/foundation.dart';

/// https://medium.com/gskinner-team/flutter-simplify-platform-screen-size-detection-4cb6fc4f7ed1
class YQDevice {
  static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);

  static bool get isMobile => isAndroid || isIOS;

  static bool get isWeb => kIsWeb;

  static bool get isReleaseMode => kReleaseMode;

  static bool get isWindows => !isWeb && Platform.isWindows;

  static bool get isLinux => !isWeb && Platform.isLinux;

  static bool get isMacOS => !isWeb && Platform.isMacOS;

  static bool get isAndroid => !isWeb && Platform.isAndroid;

  static bool get isFuchsia => !isWeb && Platform.isFuchsia;

  static bool get isIOS => !isWeb && Platform.isIOS;

  static String get operatingSystem => Platform.operatingSystem;

// ///获取设备信息
// static get deviceInfo async {
//   final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//   Map<String, dynamic> deviceData = <String, dynamic>{};
//   AndroidDeviceInfo? androidInfo;
//   IosDeviceInfo? iosInfo;
//   if (Platform.isIOS) {
//     iosInfo = await deviceInfoPlugin.iosInfo;
//   } else {
//     androidInfo = await deviceInfoPlugin.androidInfo;
//   }
//   deviceData = _readDeviceInfo(androidInfo, iosInfo);
//   return deviceData;
// }
//
// static _readDeviceInfo(
//     AndroidDeviceInfo? androidInfo, IosDeviceInfo? iosInfo) {
//   Map<String, dynamic> data = <String, dynamic>{
//     //手机品牌加型号
//     "brand": Platform.isIOS
//         ? iosInfo?.name
//         : "${androidInfo?.brand} ${androidInfo?.model}",
//     //当前系统版本
//     "systemVersion": Platform.isIOS
//         ? iosInfo?.systemVersion
//         : androidInfo?.version.release,
//     //系统名称
//     "Platform": Platform.isIOS ? iosInfo?.systemName : "Android",
//     //是不是物理设备
//     "isPhysicalDevice": Platform.isIOS
//         ? iosInfo?.isPhysicalDevice
//         : androidInfo?.isPhysicalDevice,
//     //用户唯一识别码
//     "uuid": Platform.isIOS
//         ? iosInfo?.identifierForVendor
//         : androidInfo?.androidId,
//     //手机具体的固件型号/Ui版本
//     "incremental": Platform.isIOS
//         ? iosInfo?.systemVersion
//         : androidInfo?.version.incremental,
//     "manufacturer":
//         Platform.isIOS ? iosInfo?.model : androidInfo?.manufacturer,
//   };
//   return data;
// }
}
