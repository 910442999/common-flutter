import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../res/gaps.dart';
import '../widget/dialog/check_box_dialog.dart';
import '../widget/dialog/menu_dialog.dart';
import '../widget/dialog/share_dialog.dart';
import '../widget/my_button.dart';
import 'toast_utils.dart';

class DialogUtil {
  ///加载对话框
  static void showLoading({String? defValue}) {
    EasyLoading.show(status: '正在加载...');
  }

  static void dismissLoading() {
    EasyLoading.dismiss();
  }

  ///警告对话框(系统)
  static void showAlert(BuildContext context, String? content,
      {String? title,
      TextSpan? textSpan,
      String? confirmText, //确定按钮文本
      String? cancelText, //取消按钮文本
      Function? onPressed,
      Function? onCancel,
      bool isCancel = true,
      bool onWillPop = true,
      bool confirmDismiss = true}) {
    List<Widget> actions = [];
    if (isCancel) {
      actions.add(CupertinoDialogAction(
        child: Text(cancelText ?? "取消",
            style: const TextStyle(
              fontSize: 18,
            )),
        onPressed: () {
          Navigator.pop(context);
          if (onCancel != null) {
            onCancel();
          }
        },
      ));
    }
    actions.add(CupertinoDialogAction(
      child: Text(confirmText ?? "确定",
          style: const TextStyle(
            fontSize: 18,
          )),
      onPressed: () {
        if (confirmDismiss) {
          Navigator.pop(context);
        }
        if (onPressed != null) {
          onPressed();
        }
      },
    ));

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => onWillPop, // 拦截Android返回键
              child: CupertinoAlertDialog(
                title: title != null && title.isNotEmpty
                    ? Text(title)
                    : Container(),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      content != null && content.isNotEmpty
                          ? Text(
                              content,
                              style: const TextStyle(fontSize: 16, height: 1.5),
                            )
                          : Gaps.empty,
                      textSpan != null
                          ? Text.rich(
                              textSpan,
                              style: const TextStyle(
                                  fontSize: 16, height: 1.5), // 设置整体大小
                            )
                          : Gaps.empty,
                    ],
                  ),
                ),
                actions: actions,
              ));
        });
  }

  ///输入警告对话框(系统)
  static void showInputAlert(BuildContext context,
      {String? title,
      String? hintText,
      String? content,
      String? inputContent,
      TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters,
      bool onWillPop = true,
      Function(String)? onPressed}) {
    //设置textfield使用的控制器对象
    TextEditingController _controller = TextEditingController();
    if (inputContent != null && inputContent.isNotEmpty) {
      _controller.text = inputContent;
    }
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
              onWillPop: () async => onWillPop, // 拦截Android返回键
              child: CupertinoAlertDialog(
                title: title != null && title.isNotEmpty
                    ? Text(title)
                    : Container(),
                content: Card(
                  color: Colors.transparent,
                  elevation: 0.0,
                  child: Column(
                    children: <Widget>[
                      content != null && content.isNotEmpty
                          ? Text(content)
                          : Container(),
                      Container(
                        constraints: const BoxConstraints(
                          maxHeight: 100.0,
                        ),
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextField(
                          controller: _controller,
                          maxLines: null,
                          keyboardType: keyboardType ?? TextInputType.multiline,
                          autofocus: true,
                          decoration: InputDecoration.collapsed(
                            hintText: hintText != null && hintText.isNotEmpty
                                ? hintText
                                : "请输入内容",
                          ),
                          inputFormatters: inputFormatters,
                        ),
                      )
                    ],
                  ),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('取消'),
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      String text = _controller.text.trim().toString();
                      if (text.isEmpty) {
                        ToastUtils.show("输入内容不能为空");
                      } else {
                        Navigator.pop(context);
                        if (onPressed != null) {
                          onPressed(text);
                        }
                      }
                    },
                    child: const Text('确定'),
                  ),
                ],
              ));
        });
  }

//底部弹窗
  static void showBottomSheetDialog(
      BuildContext mContext, Map<String, Function()> tips) {
    if (tips.isEmpty) {
      return;
    }
    showModalBottomSheet(
      context: mContext,
      builder: (context) => SafeArea(
        child: SizedBox(
          height: (60 * tips.length * 1.0),
          child: ListView.separated(
              key: UniqueKey(),
              controller: ScrollController(),
              itemCount: tips.length,
              itemBuilder: (BuildContext context, int index) {
                return MyButton(
                    minHeight: 60,
                    onPressed: () {
                      Function() clickEvent = tips.values.toList()[index];
                      Navigator.pop(mContext);
                      clickEvent();
                    });
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  color: const Color(0xffC8C8C8),
                  height: 0.5,
                );
              }),
        ),
      ),
    );
  }

  //多选
  static void showCheckBoxDialog(
      BuildContext context, String? title, List<String> options,
      {double? height, Function(int, String)? onPressed}) {
    showModalBottomSheet<List<int>>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              height: height ?? MediaQuery.of(context).size.height / 2.0,
              child: CheckBoxDialog(
                title: title ?? "请选择",
                options: options,
                onPressed: onPressed,
              ));
        });
  }

//分享弹窗
  static void shareDialog(BuildContext context, String title, String url) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext context) {
          return ShareDialog(
            title: title,
            url: url,
          );
        });
  }

//菜单弹窗
  static void menuDialog(BuildContext context, Function onSelected) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext context) {
          return MenuDialog(onSelected);
        });
  }
}
