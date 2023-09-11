import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:myplanet/theme.dart';

class CircularPercentageIndicator extends StatelessWidget {
  final double percentage;

  const CircularPercentageIndicator({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CircularPercentagePainter(percentage),
      child: Center(
        child: Text(
          '${percentage.toStringAsFixed(0)}%',
          style: TextStyle(
            fontSize: 10,
            fontWeight: bold,
          ),
        ),
      ),
    );
  }
}

class _CircularPercentagePainter extends CustomPainter {
  final double percentage;

  _CircularPercentagePainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint outerCirclePaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final Paint progressPaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = math.min(centerX, centerY) - 10;

    // Draw outer circle
    canvas.drawCircle(Offset(centerX, centerY), radius, outerCirclePaint);

    // Draw progress arc
    const double startAngle = -math.pi / 2;
    final double sweepAngle = 2 * math.pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
