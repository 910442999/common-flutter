import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';

/// 输出Log工具类
class Log {
  static const String tag = 'LOG-UTILS';
  static const int _maxLen = 5000;

  static void d(String msg, {String tag = tag}) {
    if (kDebugMode) {
      _printLog(tag, ' d ', msg);
    }
  }

  static void v(String? msg, {String tag = tag}) {
    if (kDebugMode) {
      _printLog(tag, ' v ', msg);
    }
  }

  static void e(String? msg, {String tag = tag}) {
    if (kDebugMode) {
      _printLog(tag, ' e ', msg);
    }
  }

  static void json(String msg, {String tag = tag}) {
    if (kDebugMode) {
      _printLog(tag, ' json ', "\n\n" + msg + "\n\n");
    }
  }

  static void _printLog(String? tag, String stag, Object? object) {
    String da = object?.toString() ?? 'null';
    tag = tag ?? tag;
    if (da.length <= _maxLen) {
      print('$tag$stag $da');
      return;
    }
    print(
        '$tag$stag — — — — — — — — — — — — — — — — st — — — — — — — — — — — — — — — —');
    while (da.isNotEmpty) {
      if (da.length > _maxLen) {
        print(da.substring(0, _maxLen));
        da = da.substring(_maxLen, da.length);
      } else {
        print(da);
        da = '';
      }
    }
    print(
        '$tag$stag — — — — — — — — — — — — — — — — ed — — — — — — — — — — — — — — — —');
  }
}
