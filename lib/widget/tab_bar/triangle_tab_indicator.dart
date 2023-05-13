import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///自定义底部
class TriangleTabIndicator extends Decoration {
  final Size triangleSize;

  TriangleTabIndicator(this.triangleSize);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TriangleBoxPainter(this.triangleSize);
  }
}

class _TriangleBoxPainter extends BoxPainter {
  final Size triangleSize;

  _TriangleBoxPainter(this.triangleSize);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    ///每个Tab的宽高
    Size tabSize = Size(configuration.size!.width,
        configuration.size!.height - triangleSize.height);
    final Paint paint = Paint();
    paint.color = Color(0xFFFF443D);
    paint.style = PaintingStyle.fill;

    ///画三角形
    double start = (tabSize.width - triangleSize.width) / 2;
    Path trianglePath = Path();

    ///起点
    trianglePath.moveTo(
        start + offset.dx, configuration.size!.height - triangleSize.height);

    ///中点
    trianglePath.lineTo(
        (tabSize.width / 2) + offset.dx, configuration.size!.height);

    ///终点
    trianglePath.lineTo(start + offset.dx + triangleSize.width,
        configuration.size!.height - triangleSize.height);
    canvas.drawPath(trianglePath, paint);
  }
}
