import 'package:flutter/material.dart';

Widget FormTextField(
  String label,
  IconData? icon, {
  TextEditingController? controller,
  bool obscureText = false,
  FocusNode? focusNode,
  bool notEmpty = false,
  String? value,
  FormFieldSetter<String>? onSaved,
  ValueChanged<String>? onFieldSubmitted,
  int? maxLines = 1,
  double? width,
  double? height,
  EdgeInsetsGeometry margin = const EdgeInsets.only(top: 20),
}) {
  return Container(
    width: width,
    height: height,
    margin: margin,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: TextFormField(
      style: const TextStyle(color: Colors.black, fontSize: 14),
      controller: controller ?? TextEditingController(text: value),
      obscureText: obscureText,
      focusNode: focusNode,
      maxLines: maxLines,
      scrollPadding: const EdgeInsets.all(0),
      validator: (value) {
        if (notEmpty) {
          if (value == null || value == '') {
            return '$label 不能为空';
          }
        }
        return null;
      },
      decoration: InputDecoration(
        isCollapsed: true,
        contentPadding:
            const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 15),
//这里是关键
        border: const OutlineInputBorder(),
        labelText: label,
        icon: icon != null
            ? Icon(
                icon,
                size: 20,
                color: Colors.black54,
              )
            : null,
      ),
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
    ),
  );
}
