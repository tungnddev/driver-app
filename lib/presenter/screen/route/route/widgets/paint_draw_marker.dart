import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter({this.strokeColor = Colors.black, this.strokeWidth = 3, this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);

  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

class MessageBorder extends ShapeBorder {
  final EdgeInsets padding;
  final BorderSide side;
  final double sizeArrow;

  MessageBorder({this.padding = EdgeInsets.zero, this.side = BorderSide.none, this.sizeArrow = 5});



  @override
  EdgeInsetsGeometry get dimensions => padding;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight - Offset(0, sizeArrow));
    return Path()
      ..addRRect(RRect.fromRectXY(rect, 0, 0))
      ..moveTo(rect.bottomCenter.dx - sizeArrow, rect.bottomCenter.dy)
      ..relativeLineTo(sizeArrow, sizeArrow)
      ..relativeLineTo(sizeArrow, -sizeArrow)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
  }

  @override
  ShapeBorder scale(double t) => this;
}