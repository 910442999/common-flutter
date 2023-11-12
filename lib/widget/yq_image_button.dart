import 'package:flutter/material.dart';

class YQImageButton extends StatefulWidget {
  final ImageProvider? image;
  final Function? onPressed;

  const YQImageButton({
    Key? key,
    this.onPressed,
    this.image,
  }) : super(key: key);

  @override
  _YQImageButtonState createState() => _YQImageButtonState();
}

class _YQImageButtonState extends State<YQImageButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.onPressed!();
      },
      child: Image(
        image: widget.image!,
        width: 35,
        height: 35,
      ),
    );
  }
}
