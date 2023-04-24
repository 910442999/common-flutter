import 'dart:io';

import 'package:fluwx/fluwx.dart' as fluwx;

import 'toast_utils.dart';

///[WeChatScene.SESSION]会话
///[WeChatScene.TIMELINE]朋友圈
///[WeChatScene.FAVORITE]收藏
enum WeChatScene { SESSION, TIMELINE, FAVORITE }

class WechatUtils {
  /// 打开链接
  static Future<bool> init(String appId, String universalLink) {
    return fluwx.registerWxApi(appId: appId, universalLink: universalLink);
  }

  static Future<bool> isWeChatInstalled() async {
    return await fluwx.isWeChatInstalled;
  }

  static Future<bool> shareWeChat(
      String title, String url, WeChatScene chatScene,
      {String? transaction, String? thumbnail}) async {
    fluwx.WeChatScene scene;
    if (chatScene == WeChatScene.SESSION) {
      scene = fluwx.WeChatScene.SESSION;
    } else if (chatScene == WeChatScene.TIMELINE) {
      scene = fluwx.WeChatScene.TIMELINE;
    } else {
      scene = fluwx.WeChatScene.FAVORITE;
    }
    var result = await isWeChatInstalled();
    if (result) {
      var model = fluwx.WeChatShareWebPageModel(url,
          title: title,
          thumbnail: thumbnail == null
              ? null
              : thumbnail.startsWith('https:') || thumbnail.startsWith('http:')
                  ? fluwx.WeChatImage.network(thumbnail)
                  : fluwx.WeChatImage.asset(thumbnail),
          scene: scene,
          description: transaction); //仅在android上有效。
      return fluwx.shareToWeChat(model);
    } else {
      ToastUtils.show("请检查微信是否为最新版本!");
      return false;
    }
  }

  static Future<bool> shareWeChatImage(
      String title, File file, WeChatScene chatScene,
      {String? transaction, String? thumbnail}) async {
    fluwx.WeChatScene scene;
    if (chatScene == WeChatScene.SESSION) {
      scene = fluwx.WeChatScene.SESSION;
    } else if (chatScene == WeChatScene.TIMELINE) {
      scene = fluwx.WeChatScene.TIMELINE;
    } else {
      scene = fluwx.WeChatScene.FAVORITE;
    }
    var result = await isWeChatInstalled();
    if (result) {
      var model = fluwx.WeChatShareImageModel(fluwx.WeChatImage.file(file),
          title: title,
          thumbnail: thumbnail == null
              ? null
              : thumbnail.startsWith('https:') || thumbnail.startsWith('http:')
                  ? fluwx.WeChatImage.network(thumbnail)
                  : fluwx.WeChatImage.asset(thumbnail),
          scene: scene,
          description: transaction); //仅在android上有效。
      return fluwx.shareToWeChat(model);
    } else {
      ToastUtils.show("请检查微信是否为最新版本!");
      return false;
    }
  }

  static Future<bool> shareWeChatMiniProgram(
      String url, String userName, fluwx.WeChatImage thumbnail) {
    var model = fluwx.WeChatShareMiniProgramModel(
        webPageUrl: url, userName: userName, thumbnail: thumbnail);
    return fluwx.shareToWeChat(model);
  }

  static Future<bool> payWeChat(String appId, String partnerId, String prepayId,
      String package, String nonceStr, int timestamp, String sign) async {
    return await fluwx.payWithWeChat(
        appId: appId,
        partnerId: partnerId,
        prepayId: prepayId,
        packageValue: package,
        nonceStr: nonceStr,
        timeStamp: timestamp,
        sign: sign);
  }

  /**
   * state 原样带回 防止 csrf 攻击 , 可设置为简单的随机数加 session 进行校验
   *
   */
  static Future<bool> sendWeChatAuth(String state) async {
    return await fluwx.sendWeChatAuth(scope: "snsapi_userinfo", state: state);
  }
}
