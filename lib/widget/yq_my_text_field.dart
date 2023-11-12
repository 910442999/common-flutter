import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/res/yq_colors.dart';
import '/res/yq_dimens.dart';
import '/res/yq_gaps.dart';
import '../../../utils/yq_index.dart';
import '../../../widget/yq_index.dart';

/// 输入框封装
class YQMyTextField extends StatefulWidget {
  const YQMyTextField({
    Key? key,
    required this.controller,
    this.maxLength = 16,
    this.autoFocus = false,
    this.keyboardType = TextInputType.text,
    this.hintText = '',
    this.focusNode,
    this.isInputPwd = false,
    this.getVCode,
    this.keyName,
    this.border,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.textInputFormatter,
    this.style,
    this.hintStyle,
    this.onFieldSubmitted,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode? focusNode;
  final bool isInputPwd;
  final Future<bool> Function()? getVCode;
  final InputBorder? border;
  final bool enabled;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator? validator;

  /// 用于集成测试寻找widget
  final String? keyName;
  final TextAlign textAlign;
  final List<TextInputFormatter>? textInputFormatter;

  @override
  _YQMyTextFieldState createState() => _YQMyTextFieldState();
}

class _YQMyTextFieldState extends State<YQMyTextField> {
  bool _isShowPwd = false;
  bool _isShowDelete = false;
  bool _clickable = true;

  /// 倒计时秒数
  final int _second = 120;

  /// 当前秒数
  late int _currentSecond;
  StreamSubscription? _subscription;

  @override
  void initState() {
    /// 获取初始化值
    _isShowDelete = widget.controller.text.isNotEmpty;

    /// 监听输入改变
    widget.controller.addListener(isEmpty);
    super.initState();
  }

  void isEmpty() {
    final bool isNotEmpty = widget.controller.text.isNotEmpty;

    /// 状态不一样在刷新，避免重复不必要的setState
    if (isNotEmpty != _isShowDelete) {
      setState(() {
        _isShowDelete = isNotEmpty;
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    widget.controller.removeListener(isEmpty);
    super.dispose();
  }

  Future _getVCode() async {
    final bool isSuccess = await widget.getVCode!();
    if (isSuccess != null && isSuccess) {
      setState(() {
        _currentSecond = _second;
        _clickable = false;
      });
      _subscription = Stream.periodic(const Duration(seconds: 1), (int i) => i)
          .take(_second)
          .listen((int i) {
        setState(() {
          _currentSecond = _second - i - 1;
          _clickable = _currentSecond < 1;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final bool isDark = themeData.brightness == Brightness.dark;

    Widget textField = TextFormField(
      focusNode: widget.focusNode,
      style: widget.style,
      maxLength: widget.maxLength,
      obscureText: widget.isInputPwd && !_isShowPwd,
      autofocus: widget.autoFocus,
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      textAlign: widget.textAlign,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      // 数字、手机号限制格式为0到9， 密码限制不包含汉字
      inputFormatters: (widget.keyboardType == TextInputType.number ||
              widget.keyboardType == TextInputType.phone)
          ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
          : widget.keyboardType == TextInputType.visiblePassword
              ? [FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]'))]
              : widget.textInputFormatter,
      decoration: InputDecoration(
        border: widget.border,
        contentPadding: EdgeInsets.only(right: widget.enabled ? 20 : 0),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        counterText: '',
        focusedBorder: widget.border == InputBorder.none
            ? null
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: themeData.primaryColor,
                  width: 0.8,
                ),
              ),
        enabledBorder: widget.border == InputBorder.none
            ? null
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: themeData.dividerTheme.color ?? YQColours.line,
                  width: 0.8,
                ),
              ),
      ),
    );

    /// 个别Android机型（华为、vivo）的密码安全键盘不弹出问题（已知小米正常），临时修复方法：https://github.com/flutter/flutter/issues/68571 (issues/61446)
    /// 怀疑是安全键盘与三方输入法之间的切换冲突问题。
    if (YQDevice.isAndroid) {
      textField = Listener(
        onPointerDown: (e) =>
            FocusScope.of(context).requestFocus(widget.focusNode),
        child: textField,
      );
    }

    late Widget clearButton;

    if (_isShowDelete && widget.enabled) {
      clearButton = Semantics(
        label: '清空',
        hint: '清空输入框',
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: LoadAssetImage(
            'icon_delete',
            key: Key('${widget.keyName}_delete'),
            width: 18.0,
            height: 40.0,
          ),
          onTap: () => widget.controller.text = '',
        ),
      );
    }

    late Widget pwdVisible;
    if (widget.isInputPwd) {
      pwdVisible = Semantics(
        label: '密码可见开关',
        hint: '密码是否可见',
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: LoadAssetImage(_isShowPwd ? 'icon_display' : 'icon_hide',
              key: Key('${widget.keyName}_showPwd'), width: 18.0, height: 40.0),
          onTap: () {
            setState(() {
              _isShowPwd = !_isShowPwd;
            });
          },
        ),
      );
    }

    late Widget getVCodeButton;
    if (widget.getVCode != null) {
      getVCodeButton = YQMyButton(
        key: const Key('getVerificationCode'),
        onPressed: _clickable ? _getVCode : null,
        fontSize: YQDimens.font_sp12,
        text: _clickable ? "获取验证码" : '（$_currentSecond s）',
        textColor: themeData.primaryColor,
        disabledTextColor: isDark ? YQColours.dark_text : Colors.white,
        backgroundColor: Colors.transparent,
        disabledBackgroundColor:
            isDark ? YQColours.dark_text_gray : YQColours.text_gray_c,
        radius: 1.0,
        minHeight: 26.0,
        minWidth: 76.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        side: BorderSide(
          color: _clickable ? themeData.primaryColor : Colors.transparent,
          width: 0.8,
        ),
      );
    }

    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        textField,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /// _isShowDelete参数动态变化，为了不破坏树结构，false时放一个空Widget。
            /// 对于其他参数，为初始配置参数，基本可以确定树结构，就不做空Widget处理。
            if (_isShowDelete && widget.enabled) clearButton else YQGaps.empty,
            if (widget.isInputPwd) YQGaps.hGap15,
            if (widget.isInputPwd) pwdVisible,
            if (widget.getVCode != null) YQGaps.hGap15,
            if (widget.getVCode != null) getVCodeButton,
          ],
        )
      ],
    );
  }
}
