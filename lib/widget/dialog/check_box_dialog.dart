import 'package:flutter/material.dart';

import '../../utils/toast_utils.dart';
import '../my_app_bar.dart';

///多选选对话框
class CheckBoxDialog extends StatefulWidget {
  CheckBoxDialog({
    Key? key,
    required this.options,
    this.onPressed,
    this.title,
  }) : super(key: key);

  final Function(int, String)? onPressed;
  final List<String> options;
  final String? title;

  @override
  _CheckBoxDialog createState() => _CheckBoxDialog();
}

class _CheckBoxDialog extends State<CheckBoxDialog> {
  // List<bool> isChecks = [];
  // StringBuffer str_checks_tmp = new StringBuffer();
  Set<int> selected = <int>{};

  Widget getItem(int index) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        height: 42.0,
        child: CheckboxListTile(
          value: selected.contains(index),
          onChanged: (value) {
            if (mounted) {
              setState(() {
                if (selected.contains(index)) {
                  selected.remove(index);
                } else {
                  selected.add(index);
                }
              });
            }
          },
          title: Text(widget.options[index]),
          // activeColor: Colours.red,
          // selected: false,
          // checkColor: Colours.app_main,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
            centerTitle: widget.title != null ? widget.title.toString() : "",
            isBack: false,
            actionName: "完成",
            onPressed: () {
              if (selected.isEmpty) {
                ToastUtils.show("至少选择一个选项！");
                return;
              }

              if (widget.onPressed != null) {
                // widget.onPressed!(
                //     num,
                //     str_checks_tmp
                //         .toString()
                //         .substring(0, str_checks_tmp.toString().length - 1)
                //         .toString());
                Navigator.of(context).pop();
              }
              // Navigator.pop(context);
            }),
        body: ListView.builder(
          itemExtent: 48.0,
          itemBuilder: (_, index) {
            return getItem(index);
          },
          itemCount: widget.options.length,
        ));
  }
}
