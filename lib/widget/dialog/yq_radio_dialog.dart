import 'package:flutter/material.dart';
import '../../res/yq_index.dart';

///单选对话框
class YQRadioDialog extends StatefulWidget {
  YQRadioDialog({
    Key? key,
    this.list,
    this.onPressed,
    this.title,
    this.value = 0,
    this.activeColor,
    this.activeWidget,
  }) : super(key: key);

  final Function(int, String)? onPressed;
  final List<String>? list;
  final String? title;
  int value;
  Color? activeColor;
  Widget? activeWidget;

  @override
  _YQRadioDialog createState() => _YQRadioDialog();
}

class _YQRadioDialog extends State<YQRadioDialog> {
  Widget getItem(int index) {
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          height: 42.0,
          child: Row(
            children: <Widget>[
              YQGaps.hGap16,
              Expanded(
                child: Text(
                  widget.list![index],
                  style: widget.value == index
                      ? TextStyle(
                          fontSize: 14,
                          color: widget.activeColor,
                          fontWeight: FontWeight.bold)
                      : TextStyle(
                          fontSize: 14,
                          color: YQColours.text,
                          fontWeight: FontWeight.bold),
                ),
              ),
              if (widget.activeWidget != null && widget.value == index)
                widget.activeWidget!,
              // Offstage(
              //     offstage: widget.value != index,
              //     child: ),
              YQGaps.hGap16,
            ],
          ),
        ),
        onTap: () {
          if (mounted) {
            setState(() {
              widget.value = index;
            });
            widget.onPressed!(widget.value, widget.list![widget.value]);
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
