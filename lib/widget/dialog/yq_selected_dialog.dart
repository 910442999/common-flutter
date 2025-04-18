import 'package:flutter/material.dart';
import 'package:yqcommon/widget/yq_index.dart';
import 'package:yqcommon/widget/yq_index.dart';
import 'package:yqcommon/widget/yq_index.dart';
import 'package:yqcommon/widget/yq_index.dart';
import 'package:yqcommon/widget/yq_index.dart';
import 'package:yqcommon/widget/yq_index.dart';
import '../../res/yq_index.dart';

///单选对话框
class YQSelectedDialog extends StatefulWidget {
  YQSelectedDialog({
    Key? key,
    this.list,
    this.onPressed,
    this.title,
  }) : super(key: key);

  final Function(int, String)? onPressed;
  final List<String>? list;
  final String? title;

  @override
  _YQSelectedDialog createState() => _YQSelectedDialog();
}

class _YQSelectedDialog extends State<YQSelectedDialog> {
  Widget getItem(int index) {
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          height: 42.0,
          child: Text(
            widget.list![index],
            style: TextStyle(
                fontSize: 14,
                color: YQColours.text,
                fontWeight: FontWeight.bold),
          ),
        ),
        onTap: () {
          if (mounted) {
            widget.onPressed!(index, widget.list![index]);
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              widget.title!,
              style: YQTextStyles.textBoldDark18,
            ),
          ),
          YQGaps.line,
          YQGaps.vGap12,
          Expanded(
            child: ListView.builder(
              itemExtent: 48.0,
              itemBuilder: (_, index) {
                return getItem(index);
              },
              itemCount: widget.list!.length,
            ),
          ),
        ]);
  }
}
