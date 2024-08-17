import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yqcommon/utils/yq_text_util.dart';

class YQImageUtils {
  static ImageProvider getAssetImage(String name,
      {ImageFormat format = ImageFormat.png}) {
    return AssetImage(getImgPath(name, format: format));
  }

  static String getImgPath(String name,
      {ImageFormat format = ImageFormat.png}) {
    return 'assets/images/$name.${format.value}';
  }

  // static ImageProvider getImageProvider(String? imageUrl, {String holderImg = 'none'}) {
  //   if (YQTextUtil.isEmpty(imageUrl)) {
  //     return AssetImage(holderImg);
  //   }
  //   return Image(imageUrl!);
  // }
}

enum ImageFormat { png, jpg, gif, webp }

extension ImageFormatExtension on ImageFormat {
  String get value => ['png', 'jpg', 'gif', 'webp'][index];
}
