import 'package:flutter/material.dart';
import '/res/yq_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';

/**
 * 自定义Chip
 */
Widget YQChipWidget(BuildContext context, String name, bool isSelected,
    { double? width,
      Color? borderColor,
      Color unBorderColor = YQColours.bg_gray,
      Color? textColor,
      Color unTextColor = YQColours.text_gray,
      double fontSize = 12,
      double minFontSize = 8,
      int maxLines = 1,
      BorderRadiusGeometry? borderRadius,
      bool border = true, //边框or填充
      EdgeInsetsGeometry? padding,
      EdgeInsetsGeometry? margin,
      AlignmentGeometry? alignment,
      TextAlign? textAlign
    }) {
  Color primaryColor = Theme
      .of(context)
      .primaryColor;
  return Container(
    width: width,
    padding: padding,
    alignment: alignment,
    margin: margin,
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
    child: AutoSizeText(
      name,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: fontSize,
          color: isSelected ? textColor ?? primaryColor : YQColours.text_gray),
      minFontSize: minFontSize,
      maxLines: maxLines,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
