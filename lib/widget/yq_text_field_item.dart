import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../res/yq_gaps.dart';
import '../res/yq_styles.dart';
import '../utils/yq_number_text_input_formatter.dart';

/// 封装输入框
class YQTextFieldItem extends StatelessWidget {

  const YQTextFieldItem({
    Key? key,
    this.controller,
    required this.title,
    this.keyboardType = TextInputType.text,
    this.hintText = '',
    this.focusNode,
    this.width,
  }) : super(key: key);

  final TextEditingController? controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final Row child = Row(
      children: <Widget>[
        Container(
          width: width,
          child: Text(title),
        ),
        YQGaps.hGap16,
        Expanded(
          child: Semantics(
            label: hintText.isEmpty ? '请输入$title' : hintText,
            child: TextField(
              focusNode: focusNode,
              keyboardType: keyboardType,
              inputFormatters: _getInputFormatters(),
              controller: controller,
              //style: TextStyles.textDark14,
              decoration: InputDecoration(
                  hintText: hintText.isEmpty ? '请输入$title' : hintText,
                  border: InputBorder.none, //去掉下划线
                  hintStyle: YQTextStyles.textGray14
              ),
            ),
          ),
        ),
        YQGaps.hGap16
      ],
    );

    return Container(
      height: 50.0,
      margin: const EdgeInsets.only(left: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context, width: 0.6),
        ),
      ),
      child: child,
    );
  }

  List<TextInputFormatter>? _getInputFormatters() {
    if (keyboardType == const TextInputType.numberWithOptions(decimal: true)) {
      return <TextInputFormatter>[YQNumberTextInputFormatter()];
    }
    if (keyboardType == TextInputType.number ||
        keyboardType == TextInputType.phone) {
      return <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];
    }
    return null;
  }
}
