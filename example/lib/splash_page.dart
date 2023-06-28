import 'dart:async';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // String url = 'http://3g.163.com/links/4636'; // 网易新闻下载地址，地址可能失效，在测试时候可以先确认下下载地址是否是有效的
  // String url = 'itms-apps://itunes.apple.com/cn/app/id414478124?mt=8'; // 这是微信的地址，到时候换成自己的应用的地址

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
            child: GestureDetector(
          child: Text('更新弹窗'),
          onTap: () {

          },
        )));
  }
}
