import 'package:flutter/material.dart';
import 'package:yqcommon/utils/index.dart';

import '../res/colors.dart';

typedef clickCallback = void Function(int value);

/// 显示数量子控件 (购物车)
class CountItemWidget extends StatefulWidget {
  /// 数量
  int count;

  /// 乘数
  int multiplier;

  /// 是否可以点击
  bool isEnable;

  final clickCallback addClick;
  final clickCallback subClick;
  String? toastContent;

  CountItemWidget({
    Key? key,
    this.isEnable = true,
    required this.count,
    this.toastContent,
    required this.multiplier,
    required this.addClick,
    required this.subClick,
  }) : super(key: key);

  _CountItemWidgetState createState() => _CountItemWidgetState();
}

class _CountItemWidgetState extends State<CountItemWidget> {
  /// 数量
  late int _count;
  String? toastContent;
  late int _multiplier;

  void initState() {
    super.initState();
    this._count = widget.count;
    this._multiplier = widget.multiplier;
    this.toastContent = widget.toastContent;
  }

  Widget _centerNumber() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        width: 1,
        color: Colors.black12,
      )),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: 40,
            height: 22,
            child: Text(
                "${this._multiplier == null || this._multiplier < 1 ? this._count : this._count * this._multiplier}",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colours.black_333333,
                )),
            decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(
                    width: 0.5,
                    color: Colors.black12,
                  ),
                  right: BorderSide(
                    width: 1,
                    color: Colors.black12,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rightNumber() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (!widget.isEnable) {
          print("禁止响应");
          if (toastContent != null) ToastUtils.show(toastContent!);
          return;
        }
        setState(() {
          this._count++;
        });
        widget.addClick(this._count);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          width: 1,
          color: Colors.black12,
        )),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 22,
              height: 22,
              child: Text("+",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colours.red,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _leftNumber() {
    return GestureDetector(
      onTap: () {
        if (!widget.isEnable) {
          print("禁止响应");
          return;
        }

        if (this._count > 1) {
          setState(() {
            this._count--;
          });
        }
        widget.subClick(this._count);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          width: 1,
          color: Colors.black12,
        )),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 22,
              height: 22,
              child: Text("-",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colours.blue,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          this._leftNumber(),
          this._centerNumber(),
          this._rightNumber(),
        ],
      ),
    );
  }
}
