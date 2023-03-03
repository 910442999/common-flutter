import 'package:flutter/material.dart';

import '../res/index.dart';

/**
 * 复选框
 */
Widget CheckBoxWidget(String name, bool isSelected,
    {Color borderColor = Colours.app_main,
    Color textColor = Colours.material_bg,
    double fontSize = 13,
    EdgeInsetsGeometry? padding,
    VoidCallback? onPressed}) {
  var child = Container(
    alignment: Alignment.center,
    padding: padding,
    child: Text(
      name,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: isSelected ? Colours.material_bg : Colours.text_gray,
          fontSize: fontSize),
    ),
    decoration: isSelected
        ? BoxDecoration(
            color: Colours.app_main,
            borderRadius: BorderRadius.circular(20.0),
          )
        : BoxDecoration(
            color: Colours.gray_e8e8e8,
            borderRadius: BorderRadius.circular(20.0),
          ),
  );
  return onPressed == null
      ? child
      : GestureDetector(
          behavior: HitTestBehavior.opaque, child: child, onTap: onPressed);
}
