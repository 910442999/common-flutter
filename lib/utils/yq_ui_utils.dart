import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../res/yq_colors.dart';
import '/utils/yq_toast_utils.dart';
import 'yq_number_text_input_formatter.dart';

enum YQInputFormat { text, noText, decimal, number, pinyin, pinyinNumber }

class YQUiUtils {
  /// 打开链接
  /// 需要参考https://pub.flutter-io.cn/packages/url_launcher 配置 URL schemes
  static void launchWebURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      YQToastUtils.show('打开链接失败！');
    }
  }

  /// 调起拨号页
  static void launchTelUri(String phone) async {
    final Uri url = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      YQToastUtils.show('拨号失败！');
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
      YQToastUtils.show('发送短信失败！');
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
      keyboardBarColor: YQColours.bg_color,
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
    YQToastUtils.show("复制成功!");
  }

  ///输入格式拦截器
  static List<TextInputFormatter> inputFormatters(YQInputFormat inputFormat,
      {int? size}) {
    List<TextInputFormatter> textInputFormatter = [];
    if (inputFormat == YQInputFormat.decimal) {
//      return [WhitelistingTextInputFormatter(RegExp("[0-9.]"))];
      textInputFormatter.add(YQNumberTextInputFormatter());
    } else if (inputFormat == YQInputFormat.number) {
      //只允许输入数字
      textInputFormatter.add(FilteringTextInputFormatter.digitsOnly);
    } else if (inputFormat == YQInputFormat.pinyin) {
      //只允许输入字母
      textInputFormatter
          .add(FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")));
    } else if (inputFormat == YQInputFormat.pinyinNumber) {
      //只允许输入字母和数字
      textInputFormatter
          .add(FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")));
    } else if (inputFormat == YQInputFormat.text) {
      //只允许输入汉字
      textInputFormatter
          .add(FilteringTextInputFormatter.allow(RegExp('[\u4e00-\u9fa5]')));
    } else if (inputFormat == YQInputFormat.noText) {
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
extension YQStringExtension on String? {
  String get nullSafe => this ?? '';
}
