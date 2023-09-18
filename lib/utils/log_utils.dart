import 'dart:developer';
import 'package:flutter/foundation.dart';

/// 输出Log工具类
class Log {
  static const String tag = 'LOG-UTILS';

  static void v(String? msg, {String tag = tag, int level = 100}) {
    if (kDebugMode) {
      _printLog(tag, level, msg);
    }
  }

  static void d(String msg, {String tag = tag, int level = 500}) {
    if (kDebugMode) {
      _printLog(tag, level, msg);
    }
  }

  static void e(String? msg, {String tag = tag, int level = 1000}) {
    if (kDebugMode) {
      _printLog(tag, level, msg);
    }
  }

  static void json(String msg, {String tag = tag, int level = 1500}) {
    if (kDebugMode) {
      _printLog(tag, level, "\n\n" + msg + "\n\n");
    }
  }

  static void _printLog(String? tag, int level, Object? object) {
    String da = object?.toString() ?? 'null';
    debugPrint("[${tag ?? Log.tag}] : $da");
  }
}
