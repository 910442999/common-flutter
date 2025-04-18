import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:yqcommon/utils/yq_index.dart';

import 'splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return const OKToast(
        backgroundColor: Colors.black54,
        textPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        dismissOtherOnShow: true,
        position: ToastPosition.bottom,
        child: MaterialApp(home: SplashPage()));
  }
}
