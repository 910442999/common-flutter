/**
 * @Author: Sky24n
 * @GitHub: https://github.com/Sky24n
 * @Description: Text Util.
 * @Date: 2019/7/9
 */

/// Text Util.
class YQTextUtil {
  /// isEmpty
  static bool isEmpty(String? text) {
    return text == null ||
        text == "null" ||
        text == "" ||
        text.isEmpty ||
        text
            .trim()
            .toString()
            .isEmpty;
  }

  static String isEmptyToData(String text, String defaults) {
    if (isEmpty(text)) {
      return defaults;
    } else {
      return text;
    }
  }

  /// 每隔 x位 加 pattern
  static String formatDigitPattern(String text,
      {int digit = 4, String pattern = ' '}) {
    text = text.replaceAllMapped(RegExp('(.{$digit})'), (Match match) {
      return '${match.group(0)}$pattern';
    });
    if (text.endsWith(pattern)) {
      text = text.substring(0, text.length - 1);
    }
    return text;
  }

  /// 每隔 x位 加 pattern, 从末尾开始
  static String formatDigitPatternEnd(String text,
      {int digit = 4, String pattern = ' '}) {
    String temp = reverse(text);
    temp = formatDigitPattern(temp, digit: digit, pattern: pattern);
    temp = reverse(temp);
    return temp;
  }

  /// 每隔4位加空格
  static String formatSpace4(String text) {
    return formatDigitPattern(text);
  }

  /// 每隔3三位加逗号
  /// num 数字或数字字符串。int型。
  static String formatComma3(Object num) {
    return formatDigitPatternEnd(num.toString(), digit: 3, pattern: ',');
  }

  /// 每隔3三位加逗号
  /// num 数字或数字字符串。double型。
  static String formatDoubleComma3(Object num,
      {int digit = 3, String pattern = ','}) {
    List<String> list = num.toString().split('.');
    String left =
    formatDigitPatternEnd(list[0], digit: digit, pattern: pattern);
    String right = list[1];
    return '$left.$right';
  }

  /// hideNumber
  static String hideNumber(String? phoneNo,
      {int start = 3, int end = 7, String replacement = '****'}) {
    if (isEmpty(phoneNo)) {
      return "";
    } else if (phoneNo!.length < 11) {
      return phoneNo;
    }
    return phoneNo.replaceRange(start, end, replacement);
  }

  ///隐藏字符串
  static String hideString(String? string,
      {int start = 2, String replacement = '**'}) {
    if (isEmpty(string)) {
      return "";
    }
    if (string!.length > start) {
      return string!.replaceRange(start, string!.length, replacement);
    }
    return string!.replaceRange(1, string!.length, replacement);
  }

  ///隐藏字符串
  static String hideEndString(String? string,
      {int end = 2, String replacement = '**'}) {
    if (isEmpty(string)) {
      return "";
    }
    if (string!.length > end) {
      return string!.replaceRange(0, string!.length - end, replacement);
    }
    return string;
  }

  ///隐藏昵称
  static String hideName(String? string,
      {int type = 0, String replacement = '**'}) {
    if (isEmpty(string)) {
      return "";
    }
    if (type == 1 && string!.length > 2) {
      return string!.replaceRange(1, string!.length - 1, replacement);
    }
    return string!.replaceRange(0, string!.length - 1, replacement);
  }

  /// replace
  static String replace(String text, Pattern from, String replace) {
    return text.replaceAll(from, replace);
  }

  /// split
  static List<String> split(String text, Pattern pattern) {
    return text.split(pattern);
  }

  /// reverse
  static String reverse(String text) {
    if (isEmpty(text)) return '';
    StringBuffer sb = StringBuffer();
    for (int i = text.length - 1; i >= 0; i--) {
      sb.writeCharCode(text.codeUnitAt(i));
    }
    return sb.toString();
  }
}
