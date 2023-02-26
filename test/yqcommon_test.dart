// import 'package:flutter_test/flutter_test.dart';
// import 'package:yqcommon/yqcommon.dart';
// import 'package:yqcommon/yqcommon_platform_interface.dart';
// import 'package:yqcommon/yqcommon_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockYqcommonPlatform
//     with MockPlatformInterfaceMixin
//     implements YqcommonPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final YqcommonPlatform initialPlatform = YqcommonPlatform.instance;
//
//   test('$MethodChannelYqcommon is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelYqcommon>());
//   });
//
//   test('getPlatformVersion', () async {
//     Yqcommon yqcommonPlugin = Yqcommon();
//     MockYqcommonPlatform fakePlatform = MockYqcommonPlatform();
//     YqcommonPlatform.instance = fakePlatform;
//
//     expect(await yqcommonPlugin.getPlatformVersion(), '42');
//   });
// }
