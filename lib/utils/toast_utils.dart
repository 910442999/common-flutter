import 'package:fluttertoast/fluttertoast.dart';

import '../res/colors.dart';

/// Toast工具类
class ToastUtils {
  static void show(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      textColor: Colours.material_bg,
      backgroundColor: Colours.dark_bg_color,
    );
  }

  static void showError(int code, String desc) {
    Fluttertoast.showToast(
      msg: "code:$code,desc:$desc",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      textColor: Colours.material_bg,
      backgroundColor: Colours.dark_bg_color,
    );
  }

  static void cancel() {
    ToastUtils.cancel();
  }
}
