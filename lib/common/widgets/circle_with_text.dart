import 'package:flutter/material.dart';

class CircleWithText extends StatelessWidget {
  const CircleWithText({required this.number, super.key});

  final int number;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100), // 원 크기
      painter: _CirclePainter(number),
    );
  }
}

class _CirclePainter extends CustomPainter {
  _CirclePainter(this.number);
  final int number;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    canvas
      ..drawCircle(center, radius, Paint()..color = Colors.transparent)
      ..drawCircle(
        center,
        radius,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );

    // 텍스트
    final textPainter = TextPainter(
      text: TextSpan(
        text: '$number점',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      center - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) =>
      oldDelegate.number != number;
}
