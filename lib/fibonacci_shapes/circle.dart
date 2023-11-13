import 'package:flutter/material.dart';
import 'dart:math' as math;

class FibonacciCirclePainter extends CustomPainter {
  final int initialValue;
  final Color circleColor;
  final double animationValue;

  FibonacciCirclePainter(
      this.initialValue, this.circleColor, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = circleColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double a = initialValue.toDouble(), b = a + 1.0, c = a + b;
    double scaleFactor = size.width / 20;
    double offsetX = size.width / 2;
    double offsetY = size.height / 2;

    int totalCircles = 10;
    int drawnCircles = (totalCircles * animationValue).floor();
    double partialCircleAngle =
        (totalCircles * animationValue - drawnCircles) * 2 * math.pi;

    for (int i = 0; i < drawnCircles; i++) {
      _drawFullCircle(canvas, paint, a, b, scaleFactor, offsetX, offsetY, i);

      a = b;
      b = c;
      c = a + b;
    }

    if (drawnCircles < totalCircles) {
      _drawPartialCircle(canvas, paint, a, b, scaleFactor, offsetX, offsetY,
          drawnCircles, partialCircleAngle);
    }
  }

  void _drawFullCircle(Canvas canvas, Paint paint, double a, double b,
      double scaleFactor, double offsetX, double offsetY, int index) {
    final radius = scaleFactor * math.sqrt(b);
    canvas.drawCircle(Offset(offsetX, offsetY), radius, paint);
  }

  void _drawPartialCircle(
      Canvas canvas,
      Paint paint,
      double a,
      double b,
      double scaleFactor,
      double offsetX,
      double offsetY,
      int index,
      double angle) {
    final radius = scaleFactor * math.sqrt(b);
    final rect =
        Rect.fromCircle(center: Offset(offsetX, offsetY), radius: radius);
    canvas.drawArc(rect, 0, angle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
