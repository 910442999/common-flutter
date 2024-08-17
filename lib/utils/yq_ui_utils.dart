import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../res/yq_colors.dart';
import '/utils/yq_toast_utils.dart';
import 'yq_number_text_input_formatter.dart';

enum YQInputFormat { text, noText, decimal, number, pinyin, pinyinNumber }

class YQUiUtils {
  // static String formatPrice(String price,
  //     {MoneyFormat format = MoneyFormat.END_INTEGER}) {
  //   return MoneyUtil.changeYWithUnit(
  //       NumUtil.getDoubleByValueStr(price) ?? 0, MoneyUnit.YUAN,
  //       format: format);
  // }
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
