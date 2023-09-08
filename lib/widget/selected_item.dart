import 'package:flutter/material.dart';
import '../res/colors.dart';
import '../res/gaps.dart';

class SelectedItem extends StatelessWidget {
  const SelectedItem({Key? key,
    this.onTap,
    required this.title,
    this.content = '',
    this.textAlign = TextAlign.start,
    this.style,
    this.width,})
      : super(key: key);

  final GestureTapCallback? onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final TextStyle? style;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.0,
        margin: const EdgeInsets.only(right: 8.0, left: 16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, width: 0.6),
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: width,
              child: Text(title),
            ),
            Gaps.hGap16,
            Expanded(
              child: Text(content,
                  maxLines: 2,
                  textAlign: textAlign,
                  overflow: TextOverflow.ellipsis,
                  style: style),
            ),
            Gaps.hGap8,
            if(onTap != null)
              Icon(
                Icons.chevron_right,
                size: 25,
                color: Colours.dark_text,
              )
          ],
        ),
      ),
    );
  }
}
