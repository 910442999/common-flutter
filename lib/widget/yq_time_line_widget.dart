import 'package:flutter/material.dart';

import '../../../res/yq_colors.dart';
import '../../../res/yq_gaps.dart';
import '../../../res/yq_styles.dart';

class YQTimeLineWidget extends StatefulWidget {
  int type;
  String title;
  String? content;
  Widget? widget;
  Color colorPrimary;

  YQTimeLineWidget({
    required this.title,
    this.content,
    this.widget,
    required this.colorPrimary,
    this.type = 0,
  });

  @override
  _YQTimeLineWidgetState createState() => _YQTimeLineWidgetState();
}

class _YQTimeLineWidgetState extends State<YQTimeLineWidget> {
  double item_height = 0.0;
  GlobalKey textKey = new GlobalKey();

  @override
  void initState() {
// TODO: implement initState

    super.initState();

    ///  监听是否渲染完

    WidgetsBinding widgetsBinding = WidgetsBinding.instance;

    widgetsBinding.addPostFrameCallback((callback) {
      ///  获取相应控件的size

      RenderObject? renderObject = textKey.currentContext?.findRenderObject();
      if (renderObject != null) {
        setState(() {
          item_height = renderObject.semanticBounds.size.height;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          ///  左侧的线
          Container(
            width: 14,
            height: item_height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  width: 0.9,
                  color: widget.type == 1
                      ? YQColours.translucent
                      : widget.colorPrimary,
                )),
                Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    color: widget.colorPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                  ),
                ),
                Expanded(
                    child: Container(
                  width: 0.9,
                  color: widget.type == 2
                      ? YQColours.translucent
                      : widget.colorPrimary,
                )),
              ],
            ),
          ),

          ///  右侧的文案

          Expanded(
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.grey[100],
              ),
              key: textKey,
              padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: YQTextStyles.textBoldDark16),
                    if (widget.content != null) YQGaps.vGap5,
                    if (widget.content != null)
                      Text(
                        widget.content.toString(),
                        style: YQTextStyles.textGray14,
                      ),
                    if (widget.widget != null) YQGaps.vGap5,
                    if (widget.widget != null) widget.widget!,
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
