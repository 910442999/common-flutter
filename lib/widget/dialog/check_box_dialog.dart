import 'package:flutter/material.dart';

import '../../utils/toast_utils.dart';
import '../my_app_bar.dart';

///多选选对话框
class CheckBoxDialog extends StatefulWidget {
  CheckBoxDialog({
    Key? key,
    required this.options,
    required this.onPressed,
    this.title,
  }) : super(key: key);

  final Function(List<int>, List<String>) onPressed;
  final List<String> options;
  final String? title;

  @override
  _CheckBoxDialog createState() => _CheckBoxDialog();
}

class _CheckBoxDialog extends State<CheckBoxDialog> {
  Set<int> selectedIndex = <int>{};
  Set<String> selectedData = <String>{};

  Widget getItem(int index) {
    String data = widget.options[index];
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        height: 42.0,
        child: CheckboxListTile(
          value: selectedIndex.contains(index),
          onChanged: (value) {
            if (mounted) {
              setState(() {
                if (selectedIndex.contains(index)) {
                  selectedIndex.remove(index);
                  selectedData.remove(index);
                } else {
                  selectedIndex.add(index);
                  selectedData.add(data);
                }
              });
            }
          },
          title: Text(data),
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
              if (selectedIndex.isEmpty) {
                ToastUtils.show("至少选择一个选项！");
                return;
              }
              widget.onPressed(selectedIndex.toList(), selectedData.toList());
              Navigator.of(context).pop();
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
