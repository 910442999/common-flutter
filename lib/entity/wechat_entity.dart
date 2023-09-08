class WeChatEntity {
  WeChatEntity({
    this.accessToken,
    // this.expiresIn,
    // this.refreshToken,
    this.openid,
    this.scope,
    this.nickname,
    this.sex,
    this.province,
    this.city,
    this.country,
    this.headimgurl,
    this.unionid,
  });

  String? accessToken;

  // int? expiresIn;
  // String? refreshToken;
  String? openid;
  String? scope;
  String? nickname;
  int? sex;
  String? province;
  String? city;
  String? country;
  String? headimgurl;
  String? unionid;

  factory WeChatEntity.fromJson(Map<String, dynamic> json) => WeChatEntity(
        accessToken: json["access_token"],
        // expiresIn: json["expires_in"],
        // refreshToken: json["refresh_token"],
        openid: json["openid"],
        scope: json["scope"],
        nickname: json["nickname"],
        sex: json["sex"],
        province: json["province"],
        city: json["city"],
        country: json["country"],
        headimgurl: json["headimgurl"],
        unionid: json["unionid"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        // "expires_in": expiresIn,
        // "refresh_token": refreshToken,
        "openid": openid,
        "scope": scope,
        "nickname": nickname,
        "sex": sex,
        "province": province,
        "city": city,
        "country": country,
        "headimgurl": headimgurl,
        "unionid": unionid,
      };
}
