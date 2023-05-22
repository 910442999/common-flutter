import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ota_update/ota_update.dart';
import '/res/colors.dart';
import '/res/dimens.dart';
import '/res/gaps.dart';
import '/res/styles.dart';
import '../../../utils/index.dart';
import '/widget/my_button.dart';

class UpdateDialog extends StatefulWidget {
  String versionName;
  String upgradeInfo;
  String updateUrl;
  String updateHead;
  String destinationFilename;
  int serverFlag;
  final VoidCallback? onPressed;

  UpdateDialog(this.versionName, this.upgradeInfo, this.updateUrl,
      this.updateHead, this.destinationFilename, this.serverFlag,
      {Key? key, this.onPressed})
      : super(key: key);

  @override
  _UpdateDialogState createState() => _UpdateDialogState(
      this.versionName,
      this.upgradeInfo,
      this.updateUrl,
      this.serverFlag,
      this.updateHead,
      this.destinationFilename,
      onPressed: this.onPressed);
}

class _UpdateDialogState extends State<UpdateDialog> {
  _UpdateDialogState(this.versionName, this.upgradeInfo, this.updateUrl,
      this.serverFlag, this.updateHead, this.destinationFilename,
      {this.onPressed});

  // final CancelToken _cancelToken = CancelToken();
  bool _isDownload = false;
  double _value = 0;
  String versionName;
  String upgradeInfo;
  String updateUrl;
  String updateHead;
  String destinationFilename;
  int serverFlag;
  final VoidCallback? onPressed;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return WillPopScope(
      onWillPop: () async {
        /// 使用false禁止返回键返回，达到强制升级目的
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 120.0,
                  width: 280.0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    image: DecorationImage(
                      image: AssetImage(updateHead),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 280.0,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0))),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('新版本更新', style: TextStyles.textSize16),
                      Text('V' + versionName, style: TextStyles.textSize16),
                      Gaps.vGap10,
                      Container(
                          height: 100,
                          child:
                              SingleChildScrollView(child: Text(upgradeInfo))),
                      Gaps.vGap15,
                      if (_isDownload)
                        LinearProgressIndicator(
                          backgroundColor: Colours.line,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(primaryColor),
                          value: _value,
                        )
                      else
                        _buildButton(context),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildButton(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 110.0,
          height: 36.0,
          child: MyButton(
            text: serverFlag == 1 ? "稍后" : "退出",
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            fontSize: Dimens.font_sp16,
            textColor: primaryColor,
            disabledTextColor: Colors.white,
            disabledBackgroundColor: Colours.text_gray_c,
            radius: 18.0,
            side: BorderSide(
              color: primaryColor,
              width: 0.8,
            ),
            backgroundColor: Colors.transparent,
            onPressed: () async {
              Navigator.pop(context);
              if (serverFlag != 1) {
                await SystemNavigator.pop();
              } else if (onPressed != null) {
                onPressed!();
              }
            },
          ),
        ),
        SizedBox(
          width: 110.0,
          height: 36.0,
          child: MyButton(
            text: '立即更新',
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            fontSize: Dimens.font_sp16,
            onPressed: () {
              _updateVersion();
            },
            textColor: Colors.white,
            backgroundColor: primaryColor,
            disabledTextColor: Colors.white,
            disabledBackgroundColor: Colours.text_gray_c,
            radius: 18.0,
          ),
        )
      ],
    );
  }

  void _updateVersion() async {
    if (Platform.isIOS) {
      UiUtils.launchWebURL(updateUrl);
    } else if (Platform.isAndroid) {
      try {
        OtaUpdate()
            .execute(updateUrl, destinationFilename: destinationFilename)
            .listen(
          (OtaEvent event) {
            if (kDebugMode) {
              Log.e('status:${event.status},value:${event.value}');
            }
            switch (event.status) {
              case OtaStatus.DOWNLOADING: // 下载中
                if (kDebugMode) Log.e('下载进度:${event.value}%');
                setState(() {
                  _isDownload = true;
                  _value = double.parse(event.value!) / 100;
                });
                break;
              case OtaStatus.INSTALLING: //安装中
                // Navigator.pop(context);
                setState(() {
                  _isDownload = false;
                });
                break;
              case OtaStatus.PERMISSION_NOT_GRANTED_ERROR: // 权限错误
                setState(() {
                  _isDownload = false;
                });
                DialogUtil.showAlert(context, "升级需要访问您的存储功能，您可以打开设置重新授权。",
                    confirmText: "打开设置", cancelText: "拒绝", onPressed: () {
                  PermissionUtils.openAppSetting();
                });
                break;
              default: // 其他问题
                ToastUtils.show('下载失败!');
                setState(() {
                  _isDownload = false;
                });
                break;
            }
          },
        );
      } catch (e) {
        ToastUtils.show('下载失败!');
        setState(() {
          _isDownload = false;
        });
      }
    }
  }
}
