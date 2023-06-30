import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart';
import '../../res/gaps.dart';
import '../../utils/index.dart';

class ShareDialog extends StatelessWidget {
  List<String> nameItems;
  List<String> urlItems;

  ShareDialog(
    this.nameItems,
    this.urlItems, {
    required this.title,
    required this.url,
    this.imageUrl,
    this.transaction,
    this.height,
    this.showCancel,
  });

  final String url;
  final String title;
  final String? imageUrl;
  final String? transaction;
  double? height;
  bool? showCancel;

  @override
  Widget build(BuildContext context) {
    // double itemHeight = (nameItems.length / 4 + 1).floor() * 50;
    return SafeArea(
        child: Container(
      height: height ?? (showCancel ?? true ? 130 : 80),
      decoration: const BoxDecoration(
        color: Colors.white,
        //设置四周圆角 角度
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              itemWidget(context, 0),
              itemWidget(context, 1),
              itemWidget(context, 2)
            ],
          ),
          showCancel ?? true
              ? Container(
                  height: 5,
                  color: Colors.grey[200],
                )
              : Gaps.empty,
          showCancel ?? true
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    child: const Text(
                      '取  消',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ),
                )
              : Gaps.empty,
        ],
      ),
    ));
  }

  Widget itemWidget(BuildContext context, int index) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _share(index);
          if (showCancel ?? true) Navigator.pop(context);
        },
        child: Container(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                urlItems[index],
                width: 40.0,
                height: 40.0,
                fit: BoxFit.fill,
              ),
              Text(nameItems[index]),
            ],
          ),
        ));
  }

void _share(int type) {
  if (type == 0) {
    _shareWeChat(WeChatScene.session);
  } else if (type == 1) {
    _shareWeChat(WeChatScene.timeline);
  } else {
    UiUtils.clipboard(url);
  }
}

void _shareWeChat(WeChatScene chatScene) {
  WechatUtils.shareWeChat(title, url, chatScene,
      transaction: transaction, thumbnail: imageUrl);
}
}
