import 'package:oktoast/oktoast.dart';

/// Toast工具类
class YQToastUtils {
  static void show(String msg) {
    showToast(msg);
  }

  static void showError(int code, String desc) {
    showToast("code:$code,desc:$desc");
  }

  static void cancel() {
    dismissAllToast();
  }
}
