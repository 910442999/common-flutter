import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/widget/my_app_bar.dart';

class InputTextPageArgumentsData {
  InputTextPageArgumentsData({
    required this.title,
    this.content,
    this.hintText,
    this.maxLength,
    this.maxLines,
    this.keyboardType,
  });

  late String title;
  late String? content;
  late String? hintText;
  late int? maxLength;
  late int? maxLines;
  late TextInputType? keyboardType;
}

/// design/7店铺-店铺配置/index.html#artboard13
class InputTextPage extends StatefulWidget {
  const InputTextPage({
    Key? key,
    required this.title,
    this.content,
    this.hintText,
    this.maxLength,
    this.maxLines,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  final String title;
  final String? content;
  final String? hintText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLines;

  @override
  _InputTextPageState createState() => _InputTextPageState();
}

class _InputTextPageState extends State<InputTextPage> {
  final TextEditingController _controller = TextEditingController();
  List<TextInputFormatter>? _inputFormatters;
  late int _maxLength;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.content ?? '';
    _maxLength = widget.keyboardType == TextInputType.phone
        ? 11
        : widget.maxLength ?? 30;
    _inputFormatters = widget.keyboardType == TextInputType.phone
        ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
        : null;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: widget.title,
        actionName: '完成',
        onPressed: () {
          Navigator.pop<Object>(context, _controller.text);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 21.0, left: 16.0, right: 16.0, bottom: 16.0),
        child: Semantics(
          multiline: true,
          maxValueLength: _maxLength,
          child: TextField(
            maxLength: _maxLength,
            maxLines: widget.maxLines ?? 10,
            autofocus: true,
            controller: _controller,
            keyboardType: widget.keyboardType,
            inputFormatters: _inputFormatters,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
