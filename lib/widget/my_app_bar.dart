import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/res/colors.dart';
import '/res/dimens.dart';
import '/res/gaps.dart';
import '/widget/my_button.dart';

/// 自定义AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key,
    this.backgroundColor,
    this.titleColor,
    this.title = '',
    this.centerTitle = '',
    this.actionName,
    this.backImg = 'assets/images/ic_back_black.png',
    this.backImgColor,
    this.onPressed,
    this.action,
    this.isBack = true})
      : super(key: key);

  final Color? backgroundColor;
  final Color? titleColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final Color? backImgColor;
  final String? actionName;
  final VoidCallback? onPressed;
  final bool isBack;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final Color _backgroundColor = backgroundColor ?? Theme
        .of(context)
        .scaffoldBackgroundColor;

    final SystemUiOverlayStyle _overlayStyle =
    ThemeData.estimateBrightnessForColor(_backgroundColor) ==
        Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    final Widget back = isBack
        ? GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          Navigator.maybePop(context);
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            backImg,
            width: 22,
            height: 22,
            color: backImgColor ?? Colours.text,
          ),
        ))
        : Gaps.empty;
    Widget actionWidget;
    if (actionName != null && actionName!.isNotEmpty) {
      actionWidget = Positioned(
        right: 0.0,
        child: MyButton(
          key: const Key('actionName'),
          fontSize: Dimens.font_sp16,
          minWidth: 42,
          text: actionName.toString(),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          textColor: Theme
              .of(context)
              .brightness == Brightness.dark ? Colours.dark_text : Colours.text,
          backgroundColor: Colors.transparent,
          onPressed: onPressed,
        ),
      );
    } else if (action != null) {
      actionWidget = Positioned(
        right: 0.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: action!,
        ),
      );
    } else {
      actionWidget = Gaps.empty;
    }

    final Widget titleWidget = Semantics(
      namesRoute: true,
      header: true,
      child: Container(
        alignment:
        centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
        width: double.infinity,
        child: Text(
          title.isEmpty ? centerTitle : title,
          style: TextStyle(
              fontSize: Dimens.font_sp18,
              color: titleColor
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 48.0),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: _backgroundColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[titleWidget, back, actionWidget],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}
