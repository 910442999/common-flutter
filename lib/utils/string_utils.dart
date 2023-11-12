// Copyright (c) 2022 NetEase, Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

extension StringUtils on String {
  /// 截取字符串，但是不截断emoji表情
  /// emoji表情占两个字符，high+low
  String subStringWithoutEmoji(int start, [int? end]) {
    var relStart = start;
    var relEnd = end ?? length;
    if (start != 0) {
      int c = this[start].codeUnitAt(0);
      // 如果是低位代理，则开始位置直接放弃表情
      if (isLowSurrogate(c)) {
        relStart++;
      }
    }
    if (end != null && end < length) {
      int c = this[end].codeUnitAt(0);
      // 如果是低位代理，则结束位置向后移动一位，包含表情
      if (isLowSurrogate(c)) {
        relEnd++;
      }
    }
    return substring(relStart, relEnd);
  }

  bool isHighSurrogate(int codeUnit) {
    return codeUnit >= 0xD800 && codeUnit <= 0xDBFF;
  }

  bool isLowSurrogate(int codeUnit) {
    return codeUnit >= 0xDC00 && codeUnit <= 0xDFFF;
  }
}
