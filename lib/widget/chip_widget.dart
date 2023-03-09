import 'package:flutter/material.dart';
import '/res/colors.dart';

/**
 * 自定义Chip
 */
Widget ChipWidget(BuildContext context, String name, bool isSelected,
    {Color? borderColor,
    Color unBorderColor = Colours.bg_gray,
    Color textColor = Colours.text_gray,
    double fontSize = 12,
    bool border = true, //边框or填充
    EdgeInsetsGeometry? padding}) {
  Color primaryColor = Theme.of(context).primaryColor;
  return Container(
    alignment: Alignment.center,
    padding: padding,
    decoration: isSelected
        ? border
            ? BoxDecoration(
                border:
                    Border.all(width: 1, color: borderColor ?? primaryColor),
                borderRadius: BorderRadius.circular(20.0),
              )
            : BoxDecoration(
                color: borderColor ?? primaryColor,
                borderRadius: BorderRadius.circular(20.0),
              )
        : border
            ? BoxDecoration(
                border: Border.all(width: 1, color: unBorderColor),
                borderRadius: BorderRadius.circular(20.0),
              )
            : BoxDecoration(
                color: unBorderColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
    child: Text(
      name,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: isSelected ? Colours.material_bg : Colours.text_gray,
          fontSize: fontSize),
    ),
  );
}
