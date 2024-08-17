import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/yq_index.dart';

/// 图片加载（支持本地与网络图片）
class YQLoadImage extends StatelessWidget {
  YQLoadImage(
    this.image, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.format = ImageFormat.png,
    this.holderImg,
    this.cacheWidth,
    this.cacheHeight,
    this.circleRadius,
    this.borderRadius,
    this.onPressed,
  }) : super(key: key);

  String? image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final ImageFormat format;
  final String? holderImg;
  final int? cacheWidth;
  final int? cacheHeight;
  final double? circleRadius;
  final VoidCallback? onPressed;

  /// null 正常
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final Widget _image = YQLoadAssetImage(
      holderImg,
      height: height,
      width: width,
      fit: fit,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
    Widget _imageWidget;
    if (YQTextUtil.isEmpty(image)) {
      _imageWidget = _image;
    } else {
      if (borderRadius != null || circleRadius != null) {
        _imageWidget = ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(circleRadius!),
            child: Image.network(image!,
                height: height,
                width: width,
                cacheWidth: cacheWidth,
                cacheHeight: cacheHeight,
                fit: fit,
                excludeFromSemantics: true,
                errorBuilder: (context, error, stackTrace) => _image));
      } else {
        _imageWidget = Image.network(image!,
            height: height,
            width: width,
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
            fit: fit,
            excludeFromSemantics: true,
            errorBuilder: (context, error, stackTrace) => _image);
      }
    }
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: _imageWidget,
        onTap: onPressed);
  }
}

/// 加载本地资源图片
class YQLoadAssetImage extends StatelessWidget {
  const YQLoadAssetImage(this.image,
      {Key? key,
      this.width,
      this.height,
      this.cacheWidth,
      this.cacheHeight,
      this.fit,
      this.color,
      this.package,
      this.onPressed})
      : super(key: key);

  final String? image;
  final double? width;
  final double? height;
  final int? cacheWidth;
  final int? cacheHeight;
  final BoxFit? fit;
  final Color? color;
  final VoidCallback? onPressed;
  final String? package;

  @override
  Widget build(BuildContext context) {
    Widget widget = image == null
        ? SizedBox()
        : Image.asset(
            image!,
            height: height,
            width: width,
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
            fit: fit,
            color: color,
            package: package,

            /// 忽略图片语义
            excludeFromSemantics: true,
          );
    if (onPressed == null) {
      return widget;
    }
    return GestureDetector(
        behavior: HitTestBehavior.opaque, child: widget, onTap: onPressed);
  }
}

/// 加载SVG资源图片
class YQLoadSvgImage extends StatelessWidget {
  const YQLoadSvgImage(this.image,
      {Key? key, this.width, this.height, this.color, this.onPressed})
      : super(key: key);

  final String image;
  final double? width;
  final double? height;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    Widget widget = SvgPicture.asset(
      image,
      height: height,
      width: width,
      color: color,

      /// 忽略图片语义
      excludeFromSemantics: true,
    );
    if (onPressed == null) {
      return widget;
    }
    return GestureDetector(
        behavior: HitTestBehavior.opaque, child: widget, onTap: onPressed);
  }
}
