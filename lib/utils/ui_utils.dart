import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../res/colors.dart';
import '/utils/toast_utils.dart';
import 'number_text_input_formatter.dart';

enum InputFormat { text, noText, decimal, number, pinyin, pinyinNumber }

class UiUtils {
  /// 打开链接
  /// 需要参考https://pub.flutter-io.cn/packages/url_launcher 配置 URL schemes
  static void launchWebURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      ToastUtils.show('打开链接失败！');
    }
  }

  /// 调起拨号页
  static void launchTelUri(String phone) async {
    final Uri url = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ToastUtils.show('拨号失败！');
    }
  }

  //发送短信
  static void launchSmsUri(BuildContext context, String phone,
      {String? content}) async {
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: phone,
      queryParameters: content == null
          ? null
          : <String, String>{
              'body': Uri.encodeComponent(content),
            },
    );
    if (await canLaunchUrl(smsLaunchUri)) {
      await launchUrl(smsLaunchUri);
    } else {
      ToastUtils.show('发送短信失败！');
    }
  }

  // static String formatPrice(String price,
  //     {MoneyFormat format = MoneyFormat.END_INTEGER}) {
  //   return MoneyUtil.changeYWithUnit(
  //       NumUtil.getDoubleByValueStr(price) ?? 0, MoneyUnit.YUAN,
  //       format: format);
  // }

  static KeyboardActionsConfig getKeyboardActionsConfig(List<FocusNode> list) {
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

  ///输入格式拦截器
  static List<TextInputFormatter> inputFormatters(InputFormat inputFormat,
      {int? size}) {
    List<TextInputFormatter> textInputFormatter = [];
    if (inputFormat == InputFormat.decimal) {
//      return [WhitelistingTextInputFormatter(RegExp("[0-9.]"))];
      textInputFormatter.add(NumberTextInputFormatter());
    } else if (inputFormat == InputFormat.number) {
      //只允许输入数字
      textInputFormatter.add(FilteringTextInputFormatter.digitsOnly);
    } else if (inputFormat == InputFormat.pinyin) {
      //只允许输入字母
      textInputFormatter
          .add(FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")));
    } else if (inputFormat == InputFormat.pinyinNumber) {
      //只允许输入字母和数字
      textInputFormatter
          .add(FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")));
    } else if (inputFormat == InputFormat.text) {
      //只允许输入汉字
      textInputFormatter
          .add(FilteringTextInputFormatter.allow(RegExp('[\u4e00-\u9fa5]')));
    } else if (inputFormat == InputFormat.noText) {
      //不允许输入汉字
      textInputFormatter
          .add(FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]')));
    }
    if (size != null && size > 0) {
      textInputFormatter.add(LengthLimitingTextInputFormatter(size));
    }
    return textInputFormatter;
  }
}

/// String 空安全处理
extension StringExtension on String? {
  String get nullSafe => this ?? '';
}
