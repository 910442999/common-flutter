import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/index.dart';

/// 图片加载（支持本地与网络图片）
class LoadImage extends StatelessWidget {
  LoadImage(this.image, {
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
    final Widget _image = LoadAssetImage(
      holderImg,
      height: height,
      width: width,
      fit: fit,
      format: format,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
    Widget _imageWidget;
    if (TextUtil.isEmpty(image)) {
      _imageWidget = _image;
    } else {
      if (borderRadius != null || circleRadius != null) {
        _imageWidget = ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(circleRadius!),
            child: kIsWeb
                ? Image.network(
              image!,
              height: height,
              width: width,
              cacheWidth: cacheWidth,
              cacheHeight: cacheHeight,
              fit: fit,
              excludeFromSemantics: true,
            )
                : CachedNetworkImage(
              imageUrl: image!,
              placeholder: (_, __) => _image,
              errorWidget: (_, __, dynamic error) => _image,
              width: width,
              height: height,
              fit: fit,
              memCacheWidth: cacheWidth,
              memCacheHeight: cacheHeight,
            ));
      } else {
        _imageWidget = kIsWeb
            ? Image.network(
          image!,
          height: height,
          width: width,
          cacheWidth: cacheWidth,
          cacheHeight: cacheHeight,
          fit: fit,
          excludeFromSemantics: true,
        )
            : CachedNetworkImage(
          imageUrl: image!,
          placeholder: (_, __) => _image,
          errorWidget: (_, __, dynamic error) => _image,
          width: width,
          height: height,
          fit: fit,
          memCacheWidth: cacheWidth,
          memCacheHeight: cacheHeight,
        );
      }
    }
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: _imageWidget,
        onTap: onPressed);
  }
}

/// 加载本地资源图片
class LoadAssetImage extends StatelessWidget {
  const LoadAssetImage(this.image,
      {Key? key,
        this.width,
        this.height,
        this.cacheWidth,
        this.cacheHeight,
        this.fit,
        this.format = ImageFormat.png,
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
  final ImageFormat format;
  final Color? color;
  final VoidCallback? onPressed;
  final String? package;

  @override
  Widget build(BuildContext context) {
    Widget widget = image == null
        ? SizedBox(height: height,
        width: width)
        : Image.asset(
      ImageUtils.getImgPath(image!, format: format),
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
class LoadSvgImage extends StatelessWidget {
  const LoadSvgImage(this.image,
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
      "assets/svg/" + image,
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
