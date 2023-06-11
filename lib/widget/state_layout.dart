import 'package:flutter/material.dart';
import '/res/colors.dart';
import '/res/dimens.dart';
import '../../../utils/index.dart';
import '../../../widget/index.dart';

/// design/9暂无状态页面/index.html#artboard3
class StateLayout extends StatelessWidget {
  const StateLayout({Key? key,
    required this.type,
    this.hintText,
    this.image,
    this.pressedText,
    this.primaryColor,
    this.onPressed})
      : super(key: key);

  final StateType type;
  final String? hintText;
  final String? image;
  final VoidCallback? onPressed;
  final String? pressedText;
  final Color? primaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (type == StateType.loading)
            CircularProgressIndicator(
              color: primaryColor ?? Theme
                  .of(context)
                  .primaryColor,
            )
          else
            if (type != StateType.empty)
              Opacity(
                opacity:
                Theme
                    .of(context)
                    .brightness == Brightness.dark ? 0.5 : 1,
                child: LoadAssetImage(
                  image == null &&
                      TextUtil.isEmpty(image)
                      ? '${type.img}'
                      : image!,
                  width: 160,
                ),
              ),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(left: 32, right: 32, top: 30, bottom: 30),
            child: Text(
              hintText ?? type.hintText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 1.5,
                  color: Colours.gray_666666,
                  fontSize: Dimens.font_sp14
              ),
            ),
          ),
          if (onPressed != null)
            Container(
              margin: EdgeInsets.only(bottom: 50),
              child: MyButton(
                text: pressedText ?? "重新加载",
                minWidth: 120,
                minHeight: 35,
                fontSize: 15,
                onPressed: onPressed,
              ),
            )

        ]);
  }
}

enum StateType {
  /// 订单
  order,

  /// 内容
  content,

  /// 无网络
  network,

  /// 消息
  message,

  /// 账户
  account,

  /// 加载中
  loading,

  /// 空
  empty,

  /// 其他
  other
}

extension StateTypeExtension on StateType {
  String get img =>
      <String>[
        'state/zwdd',
        'state/zwsp',
        'state/zwwl',
        'state/zwxx',
        'state/zwzh',
        '',
        '',
        "other"
      ][index];

  String get hintText =>
      <String>[
        '暂无订单',
        '暂无内容',
        '网络连接异常，请检查网络！',
        '暂无消息',
        '马上添加提现账号吧',
        '正在加载...',
        '',
        "自定义"
      ][index];
}
