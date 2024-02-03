import 'package:flutter/material.dart';

import 'yq_dimens.dart';

/// 间隔
/// 官方做法：https://github.com/flutter/flutter/pull/54394
class YQGaps {
  
  /// 水平间隔
  static const Widget hGap2 = SizedBox(width: YQDimens.gap_dp2);
  static const Widget hGap4 = SizedBox(width: YQDimens.gap_dp4);
  static const Widget hGap5 = SizedBox(width: YQDimens.gap_dp5);
  static const Widget hGap8 = SizedBox(width: YQDimens.gap_dp8);
  static const Widget hGap10 = SizedBox(width: YQDimens.gap_dp10);
  static const Widget hGap12 = SizedBox(width: YQDimens.gap_dp12);
  static const Widget hGap15 = SizedBox(width: YQDimens.gap_dp15);
  static const Widget hGap16 = SizedBox(width: YQDimens.gap_dp16);
  static const Widget hGap20 = SizedBox(width: YQDimens.gap_dp20);
  static const Widget hGap32 = SizedBox(width: YQDimens.gap_dp32);
  static const Widget hGap50 = SizedBox(width: YQDimens.gap_dp50);
  static const Widget hGap60 = SizedBox(width: YQDimens.gap_dp60);

  /// 垂直间隔
  static const Widget vGap4 = SizedBox(height: YQDimens.gap_dp4);
  static const Widget vGap5 = SizedBox(height: YQDimens.gap_dp5);
  static const Widget vGap8 = SizedBox(height: YQDimens.gap_dp8);
  static const Widget vGap10 = SizedBox(height: YQDimens.gap_dp10);
  static const Widget vGap12 = SizedBox(height: YQDimens.gap_dp12);
  static const Widget vGap15 = SizedBox(height: YQDimens.gap_dp15);
  static const Widget vGap16 = SizedBox(height: YQDimens.gap_dp16);
  static const Widget vGap20 = SizedBox(height: YQDimens.gap_dp20);
  static const Widget vGap24 = SizedBox(height: YQDimens.gap_dp24);
  static const Widget vGap32 = SizedBox(height: YQDimens.gap_dp32);
  static const Widget vGap40 = SizedBox(height: YQDimens.gap_dp40);
  static const Widget vGap50 = SizedBox(height: YQDimens.gap_dp50);
  static const Widget vGap60 = SizedBox(height: YQDimens.gap_dp60);

//  static Widget line = const SizedBox(
//    height: 0.6,
//    width: double.infinity,
//    child: const DecoratedBox(decoration: BoxDecoration(color: Colours.line)),
//  );

  static const Widget line = Divider();

  static const Widget vLine = SizedBox(
    width: 0.6,
    height: 24.0,
    child: VerticalDivider(),
  );
  
  static const Widget empty = SizedBox.shrink();
}
