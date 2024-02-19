import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class YQNumChangeWidget extends StatefulWidget {
  final double height;
  int num;

  /// 乘数
  int multiplier;
  final ValueChanged<int> onValueChanged;

  final bool disabled;

  YQNumChangeWidget({Key? key,
    this.height = 26.0,
    this.num = 0,
    this.disabled = false,
    this.multiplier = 0,
    required this.onValueChanged})
      : super(key: key);

  @override
  _NumChangeWidgetState createState() {
    return _NumChangeWidgetState();
  }
}

class _NumChangeWidgetState extends State<YQNumChangeWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.all(Radius.circular(2.0)),
          border: Border.all(
            width: 1,
            color: Colors.black12,
          )),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: _minusNum,
            child: Container(
              width: widget.height,
              alignment: Alignment.center,
              child: Icon(Icons.horizontal_rule_outlined,
                  size: 20,
                  color: widget.num == 1 || widget.disabled
                      ? Colors.black26
                      : Colors.black),
            ),
          ),
          Container(
            width: 0.5,
            color: Colors.black54,
          ),
          Container(
            width: 42.0,
            height: widget.height,
            alignment: Alignment.center,
            child:
            Text(
                "${widget.multiplier == null || widget.multiplier < 1 ? widget
                    .num : widget.num * widget.multiplier}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ))
            ,
          ),
          Container(
            width: 0.5,
            color: Colors.black54,
          ),
          GestureDetector(
            onTap: _addNum,
            child: Container(
              width: widget.height,
              alignment: Alignment.center,
              child: Icon(
                Icons.add_outlined,
                size: 20,
                color: widget.disabled
                    ? Colors.black26
                    : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _minusNum() {
    if (widget.num == 1 || widget.disabled) {
      return;
    }
    setState(() {
      widget.num -= 1;
      if (widget.onValueChanged != null) {
        widget.onValueChanged(widget.num);
      }
    });
  }

  void _addNum() {
    if (widget.disabled) {
      return;
    }
    setState(() {
      widget.num += 1;
      if (widget.onValueChanged != null) {
        widget.onValueChanged(widget.num);
      }
    });
  }
}

