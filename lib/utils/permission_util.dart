import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '/utils/toast_utils.dart';
import 'dialog_util.dart';

/**
 * 动态申请权限问题
 */
class PermissionUtils {
  //请求相机权限
  static Future<bool> requestCamera(BuildContext context) async {
    List<Permission> permissionsList;
    if (Platform.isIOS) {
      permissionsList = [
        Permission.photos,
        Permission.camera,
      ];
    } else {
      permissionsList = [
        Permission.camera,
        Permission.storage,
      ];
    }
    return requestPermission(context, permissionsList);
  }

  ///请求电话权限
  static Future<bool> requestCallPhone(BuildContext context) async {
    PermissionStatus status = await Permission.phone.request();
    if (status.isGranted || status.isLimited) {
      return true;
    } else {
      return false;
    }
  }

  ///请求存储权限
  static Future<bool> requestStorage(BuildContext context) async {
    PermissionStatus status;
    if (Platform.isIOS) {
      status = await Permission.photos.request();
    } else {
      status = await Permission.storage.request();
    }
    if (status.isGranted || status.isLimited) {
      return true;
    } else {
      return false;
    }
  }

  ///请求位置权限
  static Future<bool> requestLocation(BuildContext context) async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted || status.isLimited) {
      return true;
    } else {
      return false;
    }
  }

  ///请求视频通话权限
  static Future<bool> requestVideoCall(BuildContext context) async {
    return requestPermission(
        context, [Permission.microphone, Permission.camera]);
  }

  ///请求语音通话 麦克风权限
  static Future<bool> requestAudioCall(BuildContext context) async {
    PermissionStatus status = await Permission.microphone.request();
    if (status.isGranted || status.isLimited) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 请求相关权限
   */
  static Future<bool> requestPermission(
      BuildContext context, List<Permission> permissionsList) async {
    // 申请权限
    Map<Permission, PermissionStatus> permissions =
        await permissionsList.request();

    // 申请结果 有一个未授予，则为失败
    bool permissionStatus = true;
    permissions.forEach((key, value) {
      print("--key, value--${key} ${value}");
      if (value.isGranted || value.isLimited) {
      } else {
        permissionStatus = false;
      }
    });

    if (permissionStatus) {
      return true;
    } else {
      return false;
    }
  }

  static openAppSetting() async {
    bool isOpened = await openAppSettings();
    if (!isOpened) {
      ToastUtils.show("权限未授予！");
    }
    // exit(0);
  }
}
