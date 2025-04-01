import 'package:flutter/material.dart';

class GradientOutlineBorder extends ShapeBorder {
  final Gradient gradient;
  final double width;
  final double borderRadius;

  const GradientOutlineBorder({
    required this.gradient,
    this.width = 2.0,
    this.borderRadius = 8.0,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          rect.deflate(width),
          Radius.circular(borderRadius),
        ),
      );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          rect,
          Radius.circular(borderRadius),
        ),
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(borderRadius)),
      paint,
    );
  }

  @override
  ShapeBorder scale(double t) => this;
}

class GradientCircleBorder extends ShapeBorder {
  final Gradient gradient;
  final double width;

  const GradientCircleBorder({
    required this.gradient,
    this.width = 2.0,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addOval(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(rect.center, rect.width / 2, paint);
  }

  @override
  ShapeBorder scale(double t) => this;
}