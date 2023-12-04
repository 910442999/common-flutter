import 'package:flutter/material.dart';

import '../../utils/yq_toast_utils.dart';
import '../yq_app_bar.dart';

///多选选对话框
class YQCheckBoxDialog extends StatefulWidget {
  YQCheckBoxDialog({
    Key? key,
    required this.options,
    required this.onPressed,
    this.title,
    this.activeColor,
  }) : super(key: key);

  final Function(List<int>, List<String>) onPressed;
  final List<String> options;
  final String? title;
  Color? activeColor;

  @override
  _YQCheckBoxDialog createState() => _YQCheckBoxDialog();
}

class _YQCheckBoxDialog extends State<YQCheckBoxDialog> {
  Set<int> selectedIndex = <int>{};
  Set<String> selectedData = <String>{};

  Widget getItem(int index) {
    String data = widget.options[index];
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        height: 42.0,
        child: CheckboxListTile(
          value: selectedIndex.contains(index),
          activeColor: widget.activeColor,
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
        appBar: YQAppBar(
            centerTitle: widget.title != null ? widget.title.toString() : "",
            isBack: false,
            actionName: "完成",
            onPressed: () {
              if (selectedIndex.isEmpty) {
                YQToastUtils.show("至少选择一个选项！");
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
