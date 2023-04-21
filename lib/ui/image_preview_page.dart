import 'dart:io';

import 'package:flutter/material.dart';

import '../res/index.dart';
import '../widget/index.dart';

class ImagePreviewPage extends StatefulWidget {
  final String? url;

  const ImagePreviewPage({Key? key, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ImagePreviewPageState(url);
  }
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  final String? url;

  _ImagePreviewPageState(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
          Center(
              child: SingleChildScrollView(
                child: _getImageWidget(),
              )),
          Container(
              height: 80,
              child: const MyAppBar(
                backImgColor: Colours.material_bg,
                backgroundColor: Colours.translucent50,
              ))
        ]));
  }

  //优先加载本地路径图片，否则加载网络图片
  Widget? _getImageWidget() {
    if (!url!.startsWith("http")) {
      File file = File(url!);
      if (file != null && file.existsSync()) {
        return Image.file(file);
      }
    } else {
      return Image.network(
        url!,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
            );
          }
        },
      );
      // return widget;
    }
  }
}
