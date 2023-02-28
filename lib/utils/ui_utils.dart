import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:url_launcher/url_launcher.dart';
import '../res/colors.dart';
import '/utils/toast_utils.dart';

class UiUtils {
  /// 打开链接
  static Future<void> launchWebURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ToastUtils.show('打开链接失败！');
    }
  }

  /// 调起拨号页
  static Future<void> launchTelURL(String phone) async {
    final String url = 'tel:' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ToastUtils.show('拨号失败！');
    }
  }

  // static String formatPrice(String price,
  //     {MoneyFormat format = MoneyFormat.END_INTEGER}) {
  //   return MoneyUtil.changeYWithUnit(
  //       NumUtil.getDoubleByValueStr(price) ?? 0, MoneyUnit.YUAN,
  //       format: format);
  // }

  static KeyboardActionsConfig getKeyboardActionsConfig(
      BuildContext context, List<FocusNode> list) {
    return KeyboardActionsConfig(
      keyboardBarColor: Colours.dark_bg_color,
      nextFocus: true,
      actions: List.generate(
          list.length,
          (i) => KeyboardActionsItem(
                focusNode: list[i],
                toolbarButtons: [
                  (node) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => node.unfocus(),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text(getCurrLocale() == 'zh' ? '关闭' : 'Close'),
                      ),
                    );
                  },
                ],
              )),
    );
  }

  static String? getCurrLocale() {
    return window.locale.languageCode;
  }

  ///比直接设置elevation的悬浮感更轻薄的背景阴影
  static BoxShadow lightElevation({Color baseColor = const Color(0xFFEEEEEE)}) {
    return BoxShadow(
      color: baseColor,
      blurRadius: 9,
      spreadRadius: 3,
    );
  }

  static BoxShadow supreLightElevation(
      {Color baseColor = const Color(0xFFEEEEEE)}) {
    return BoxShadow(
      color: baseColor,
      blurRadius: 6,
    );
  }

  static void clipboard(text) {
    ClipboardData data = ClipboardData(text: text);
    Clipboard.setData(data);
    ToastUtils.show("复制成功!");
  }
}

/// String 空安全处理
extension StringExtension on String? {
  String get nullSafe => this ?? '';
}
