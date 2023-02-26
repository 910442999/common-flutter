import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';

/// 输出Log工具类
class Log {
  static const String tag = 'YUANQUANAPP-LOG';
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
      try {
        final dynamic data = convert.json.decode(msg);
        if (data is Map) {
          _printMap(data);
        } else if (data is List) {
          _printList(data);
        } else {
          v(msg, tag: tag);
        }
      } catch (er) {
        e(msg, tag: tag);
      }
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
        print('$tag$stag| ${da.substring(0, _maxLen)}');
        da = da.substring(_maxLen, da.length);
      } else {
        print('$tag$stag| $da');
        da = '';
      }
    }
    print(
        '$tag$stag — — — — — — — — — — — — — — — — ed — — — — — — — — — — — — — — — —');
  }

  // https://github.com/Milad-Akarie/pretty_dio_logger
  static void _printMap(Map data,
      {String tag = tag,
      int tabs = 1,
      bool isListItem = false,
      bool isLast = false}) {
    final bool isRoot = tabs == 1;
    final String initialIndent = _indent(tabs);
    tabs++;

    if (isRoot || isListItem) {
      v('$initialIndent{', tag: tag);
    }

    data.keys.toList().asMap().forEach((index, dynamic key) {
      final bool isLast = index == data.length - 1;
      dynamic value = data[key];
      if (value is String) {
        value = '"$value"';
      }
      if (value is Map) {
        if (value.isEmpty)
          v('${_indent(tabs)} $key: $value${!isLast ? ',' : ''}', tag: tag);
        else {
          v('${_indent(tabs)} $key: {', tag: tag);
          _printMap(value, tabs: tabs);
        }
      } else if (value is List) {
        if (value.isEmpty) {
          v('${_indent(tabs)} $key: ${value.toString()}', tag: tag);
        } else {
          v('${_indent(tabs)} $key: [', tag: tag);
          _printList(value, tabs: tabs);
          v('${_indent(tabs)} ]${isLast ? '' : ','}', tag: tag);
        }
      } else {
        final msg = value.toString().replaceAll('\n', '');
        v('${_indent(tabs)} $key: $msg${!isLast ? ',' : ''}', tag: tag);
      }
    });

    v('$initialIndent}${isListItem && !isLast ? ',' : ''}', tag: tag);
  }

  static void _printList(List list, {String tag = tag, int tabs = 1}) {
    list.asMap().forEach((i, dynamic e) {
      final bool isLast = i == list.length - 1;
      if (e is Map) {
        if (e.isEmpty) {
          v('${_indent(tabs)}  $e${!isLast ? ',' : ''}', tag: tag);
        } else {
          _printMap(e, tabs: tabs + 1, isListItem: true, isLast: isLast);
        }
      } else {
        v('${_indent(tabs + 2)} $e${isLast ? '' : ','}', tag: tag);
      }
    });
  }

  static String _indent([int tabCount = 1]) => '  ' * tabCount;
}
