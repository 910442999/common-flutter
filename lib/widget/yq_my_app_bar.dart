import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/res/yq_colors.dart';
import '/res/yq_dimens.dart';
import '/res/yq_gaps.dart';
import '/widget/yq_my_button.dart';

/// 自定义AppBar
class YQMyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const YQMyAppBar({Key? key,
    this.backgroundColor,
    this.titleColor,
    this.title = '',
    this.centerTitle = '',
    this.actionName,
    this.backImg = 'assets/images/ic_back_black.png',
    this.backImgColor,
    this.onPressed,
    this.padding = const EdgeInsets.only(top: 12.0, bottom: 12),
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
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final Color _backgroundColor =
        backgroundColor ?? Theme
            .of(context)
            .appBarTheme
            .backgroundColor ?? YQColours.white_ffffff;

    final SystemUiOverlayStyle _overlayStyle =
    ThemeData.estimateBrightnessForColor(_backgroundColor) ==
        Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    final Widget back = isBack
        ? IconButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        Navigator.maybePop(context);
      },
      padding: padding,
      icon: Image.asset(backImg, color: backImgColor ?? YQColours.text),
    )
        : YQGaps.empty;
    Widget actionWidget;
    if (actionName != null && actionName!.isNotEmpty) {
      actionWidget = Positioned(
        right: 0.0,
        child: YQMyButton(
          key: const Key('actionName'),
          fontSize: YQDimens.font_sp16,
          minWidth: 42,
          text: actionName.toString(),
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          textColor: Theme
              .of(context)
              .brightness == Brightness.dark
              ? YQColours.dark_text
              : YQColours.text,
          backgroundColor: Colors.transparent,
          onPressed: onPressed,
        ),
      );
    } else if (action != null) {
      actionWidget = Positioned(
        right: 0.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: action!,
        ),
      );
    } else {
      actionWidget = YQGaps.empty;
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
          style: TextStyle(fontSize: YQDimens.font_sp18, color: titleColor),
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
