import 'package:flutter/material.dart';
import 'yq_colors.dart';
import 'yq_dimens.dart';

class YQTextStyles {
  static const TextStyle textSize12 = TextStyle(
    fontSize: YQDimens.font_sp12,
  );
  static const TextStyle textSize16 = TextStyle(
    fontSize: YQDimens.font_sp16,
  );
  static const TextStyle textBold14 =
      TextStyle(fontSize: YQDimens.font_sp14, fontWeight: FontWeight.bold);
  static const TextStyle textBold16 =
      TextStyle(fontSize: YQDimens.font_sp16, fontWeight: FontWeight.bold);
  static const TextStyle textBold18 =
      TextStyle(fontSize: YQDimens.font_sp18, fontWeight: FontWeight.bold);
  static const TextStyle textBold24 =
      TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
  static const TextStyle textBold26 =
      TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold);

  static const TextStyle textWhite14 = TextStyle(
    fontSize: YQDimens.font_sp14,
    color: Colors.white,
  );
  static const TextStyle textWhite16 = TextStyle(
    fontSize: YQDimens.font_sp16,
    color: Colors.white,
  );
  static const TextStyle textWhite18 = TextStyle(
    fontSize: YQDimens.font_sp18,
    color: Colors.white,
  );
  static const TextStyle textGray12 = TextStyle(
    fontSize: YQDimens.font_sp12,
    color: YQColours.text_gray,
  );
  static const TextStyle textGray14 = TextStyle(
    fontSize: YQDimens.font_sp14,
    color: YQColours.text_gray,
  );

  static const TextStyle textGray16 = TextStyle(
    fontSize: YQDimens.font_sp16,
    color: YQColours.text_gray,
  );
  static const TextStyle textGray18 = TextStyle(
    fontSize: YQDimens.font_sp18,
    color: YQColours.text_gray,
  );

  static const TextStyle textGray20 = TextStyle(
    fontSize: YQDimens.font_sp20,
    color: YQColours.text_gray,
  );
  static const TextStyle textBoldDark12 = TextStyle(
      fontSize: YQDimens.font_sp12,
      color: YQColours.black_333333,
      fontWeight: FontWeight.bold);
  static const TextStyle textBoldDark16 = TextStyle(
      fontSize: YQDimens.font_sp16,
      color: YQColours.black_333333,
      fontWeight: FontWeight.bold);
  static const TextStyle textBoldDark18 = TextStyle(
      fontSize: YQDimens.font_sp18,
      color: YQColours.black_333333,
      fontWeight: FontWeight.bold);
  static const TextStyle textBoldDark20 = TextStyle(
      fontSize: YQDimens.font_sp20,
      color: YQColours.black_333333,
      fontWeight: FontWeight.bold);

  static const TextStyle text = TextStyle(
      fontSize: YQDimens.font_sp14,
      color: YQColours.text,
      textBaseline: TextBaseline.alphabetic);
  static const TextStyle textDark = TextStyle(
      fontSize: YQDimens.font_sp14,
      color: YQColours.dark_text,
      textBaseline: TextBaseline.alphabetic);
  static const TextStyle textDark18 = TextStyle(
    fontSize: YQDimens.font_sp18,
    color: YQColours.black_333333,
  );
  static const TextStyle textDarkGray12 = TextStyle(
      fontSize: YQDimens.font_sp12,
      color: YQColours.dark_text_gray,
      fontWeight: FontWeight.normal);
  static const TextStyle textDarkGray14 = TextStyle(
    fontSize: YQDimens.font_sp14,
    color: YQColours.dark_text_gray,
  );
  static const TextStyle textHint14 = TextStyle(
      fontSize: YQDimens.font_sp14,
      color: YQColours.dark_unselected_item_color);
}
