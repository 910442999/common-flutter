import 'dart:io';

import 'package:fluwx/fluwx.dart';

import 'toast_utils.dart';

class WechatUtils {
  static final Fluwx fluwx = Fluwx();

  /// 打开链接
  static Future<bool> init(String appId, String universalLink) {
    return fluwx.registerApi(appId: appId, universalLink: universalLink);
  }

  static Future<bool> isWeChatInstalled() async {
    return await fluwx.isWeChatInstalled;
  }

  static Future<bool> shareWeChat(String title, String url, WeChatScene scene,
      {String? transaction, String? thumbnail}) async {
    var result = await isWeChatInstalled();
    if (result) {
      var model = WeChatShareWebPageModel(url,
          title: title,
          thumbnail: thumbnail == null
              ? null
              : thumbnail.startsWith('https:') || thumbnail.startsWith('http:')
                  ? WeChatImage.network(thumbnail)
                  : WeChatImage.asset(thumbnail),
          scene: scene,
          description: transaction); //仅在android上有效。
      return await fluwx.share(model);
    } else {
      ToastUtils.show("请检查微信是否为最新版本!");
      return false;
    }
  }

  static Future<bool> shareWeChatImage(
      String title, File file, WeChatScene scene,
      {String? transaction, String? thumbnail}) async {
    var result = await isWeChatInstalled();
    if (result) {
      var model = WeChatShareImageModel(WeChatImage.file(file),
          title: title,
          thumbnail: thumbnail == null
              ? null
              : thumbnail.startsWith('https:') || thumbnail.startsWith('http:')
                  ? WeChatImage.network(thumbnail)
                  : WeChatImage.asset(thumbnail),
          scene: scene,
          description: transaction); //仅在android上有效。
      return await fluwx.share(model);
    } else {
      ToastUtils.show("请检查微信是否为最新版本!");
      return false;
    }
  }

  static Future<bool> shareWeChatMiniProgram(
      String url, String userName, WeChatImage thumbnail) async {
    var model = WeChatShareMiniProgramModel(
        webPageUrl: url, userName: userName, thumbnail: thumbnail);
    return await fluwx.share(model);
  }

  static Future<bool> payWeChat(String appId, String partnerId, String prepayId,
      String package, String nonceStr, int timestamp, String sign) async {
    return await fluwx.pay(
        which: Payment(
      appId: appId,
      partnerId: partnerId,
      prepayId: prepayId,
      packageValue: package,
      nonceStr: nonceStr,
      timestamp: timestamp,
      sign: sign,
    ));
  }

  /**
   * state 原样带回 防止 csrf 攻击 , 可设置为简单的随机数加 session 进行校验
   *
   */
  static Future<bool> sendWeChatAuth(String state) async {
    return await fluwx.authBy(
        which: NormalAuth(
      scope: 'snsapi_userinfo',
      state: state,
    ));
  }
}
