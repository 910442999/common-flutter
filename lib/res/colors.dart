import 'package:flutter/material.dart';

class Colours {
  static const Color app_main = Color(0xFFFFD400);
  static const Color dark_app_main = Color(0xFFFFB90F);
  static const Color disabled_app_main = Color(0xFFA0A2A4);
  static const Color app_main_ffffffc9 = Color(0xFFFFFFC9);

  static const Color bg_color = Color(0xfff1f1f1);
  static const Color dark_bg_color = Color(0xFF18191A);

  static const Color material_bg = Color(0xFFFFFFFF);
  static const Color dark_material_bg = Color(0xFF303233);

  static const Color text = Color(0xFF333333);
  static const Color dark_text = Color(0xFFB8B8B8);

  static const Color text_gray = Color(0xFF999999);
  static const Color dark_text_gray = Color(0xFF666666);

  static const Color text_gray_c = Color(0xFFCCCCCC);
  static const Color dark_button_text = Color(0xFFF2F2F2);

  static const Color bg_gray = Color(0xFFF6F6F6);
  static const Color dark_bg_gray = Color(0xFF1F1F1F);

  static const Color line = Color(0xFFEEEEEE);
  static const Color dark_line = Color(0xFF3A3C3D);

  static const Color red = Color(0xFFFF4759);
  static const Color dark_red = Color(0xFFE03E4E);

  static const Color red_fb5858 = Color(0xFFFB5858);


  static const Color text_disabled = Color(0xFFF6F6F6);
  static const Color dark_text_disabled = Color(0xFFB8B8B8);

  static const Color button_disabled = Color(0xFFF0E68C);
  static const Color dark_button_disabled = Color(0xFFFFE4B5);

  static const Color unselected_item_color = Color(0xffbfbfbf);
  static const Color dark_unselected_item_color = Color(0xFF4D4D4D);

  static const Color bg_gray_ = Color(0xFFFAFAFA);
  static const Color dark_bg_gray_ = Color(0xFF242526);

  static const Color gray_e8e8e8 = Color(0xFFE8E8E8);
  static const Color gray_fdf2e8 = Color(0xFFFDF2E8);
  static const Color translucent = Color(0x00000000);
  static const Color translucent50 = Color(0x50000000);
  static const Color translucent10 = Color(0x10000000);
  static const Color white_translucent30 = Color(0x30FFFFFF);
  static const Color dark_d0d0d0 = Color(0xFFD0D0D0);

  // static const Color gradient_blue = Color(0xFF5793FA);
  // static const Color shadow_blue = Color(0x805793FA);
  static const Color yellow_784308 = Color(0xFF784308);
  static const Color yellow_fc725d = Color(0xFFFC725D);
  static const Color yellow_ff8519 = Color(0xFFFF8519);
  static const Color orange = Color(0xFFFF8547);
  static const Color yellow_fca256 = Color(0xFFFCA256);
  static const Color yellow_fccd4d = Color(0xFFFCCD4D);
  static const Color pink = Color(0xFFF9C8C8);

  static const Color white_ffffff = Color(0xFFFFFFFF);
  static const Color dark_8e8e93 = Color(0xFF8E8E93);
  static const Color black_333333 = Color(0xFF333333);
  static const Color gray_666666 = Color(0xFF666666);
  static const Color blue = Color(0xFF0091FF);
  //背景渐变，从底部到顶部
  static Gradient translucentGradient = const LinearGradient(
    colors: [Color(0x00000000), Color(0xB0000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static Gradient orangeGradient = const LinearGradient(
    colors: [Color(0xFFFC725D), yellow_fca256, yellow_fca256, yellow_fca256],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
