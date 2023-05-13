import 'package:flutter/material.dart';
import '/res/colors.dart';

/**
 * 自定义Chip
 */
Widget ChipWidget(BuildContext context, String name, bool isSelected,
    {Color? borderColor,
      Color unBorderColor = Colours.bg_gray,
      Color? textColor,
      Color unTextColor = Colours.text_gray,
      double fontSize = 12,
      BorderRadiusGeometry? borderRadius,
      bool border = true, //边框or填充
      EdgeInsetsGeometry? padding}) {
  Color primaryColor = Theme
      .of(context)
      .primaryColor;
  return Container(
    padding: padding,
    decoration: isSelected
        ? border
        ? BoxDecoration(
      border:
      Border.all(width: 1, color: borderColor ?? primaryColor),
      borderRadius: borderRadius ?? BorderRadius.circular(20.0),
    )
        : BoxDecoration(
      color: borderColor ?? primaryColor,
      borderRadius: borderRadius ?? BorderRadius.circular(20.0),
    )
        : border
        ? BoxDecoration(
      border: Border.all(width: 1, color: unBorderColor),
      borderRadius: borderRadius ?? BorderRadius.circular(20.0),
    )
        : BoxDecoration(
      color: unBorderColor,
      borderRadius: borderRadius ?? BorderRadius.circular(20.0),
    ),
    child: Text(
      name,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: isSelected ? textColor ?? primaryColor : Colours.text_gray,
          fontSize: fontSize),
    ),
  );
}
