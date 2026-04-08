import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MultiColorCircle extends StatelessWidget {
  const MultiColorCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MultiColorPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _MultiColorPainter extends CustomPainter {
  final List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.black,
    Colors.yellow,
    Colors.brown,
    Colors.purple,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final radius = size.width / 2;

    final paint = Paint()
      ..style = PaintingStyle.fill;

    double startAngle = -90 * (3.14159 / 180); // start at top
    final sweepAngle = (360 / colors.length) * (3.14159 / 180);

    for (var color in colors) {
      paint.color = color;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
