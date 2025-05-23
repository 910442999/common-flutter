import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/**
 * 可展开的文本text
 */
class YQOPRichText extends StatefulWidget {
  YQOPRichText({Key? key, this.text, this.width, this.textColor})
      : super(key: key);
  double? width;
  String? text;
  Color? textColor;

  @override
  _OPRichText createState() => _OPRichText();
}

class _OPRichText extends State<YQOPRichText> {
  // 全文、收起 的状态
  bool mIsExpansion = false;
  int mSelectIndex = -1; //默认未选中
  bool IsExpansion(String text, width) {
    TextPainter _textPainter = TextPainter(
        maxLines: 3,
        text: TextSpan(
            text: text, style: TextStyle(fontSize: 14.0, color: Colors.black)),
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: width - 180, minWidth: 50);
    if (_textPainter.didExceedMaxLines) {
      //判断 文本是否需要截断
      return true;
    } else {
      return false;
    }
  }

  void _isShowText() {
    if (mIsExpansion) {
      //关闭
      setState(() {
        mIsExpansion = false;
      });
    } else {
      //打开
      setState(() {
        mIsExpansion = true;
      });
    }
  }

  // ignore: non_constant_identifier_names
  Widget _RichText(String _text, width) {
    if (IsExpansion(_text, width)) {
      //是否截断
      if (mIsExpansion) {
        return Text.rich(
          TextSpan(
              text: _text,
              style: TextStyle(
                color: Color(0XFF333333),
                fontSize: 14,
              ),
              children: [
                TextSpan(
                    text: '收起',
                    style: TextStyle(
                        color: widget.textColor == null
                            ? Colors.white
                            : widget.textColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        _isShowText();
                      })
              ]),
        );
      } else {
        return Stack(
          children: <Widget>[
            Text(
              _text,
              style: TextStyle(color: Color(0XFF333333), fontSize: 14),
              maxLines: 3,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _isShowText();
                },
                child: Container(
                  width: 100,
                  color: widget.textColor == null
                      ? Color(0xFF7ACFD6)
                      : Colors.white,
                  child: Text(
                    '展开',
                    style: TextStyle(
                        color: widget.textColor == null
                            ? Colors.white
                            : widget.textColor,
                        fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    } else {
      return Text(
        _text,
        maxLines: 3,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _RichText(widget.text!, widget.width);
  }
}
