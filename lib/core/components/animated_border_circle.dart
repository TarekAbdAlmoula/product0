import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:product0/core/utils/constants.dart';

class AnimatedBorderCircle extends StatefulWidget {
  @override
  _AnimatedBorderCircleState createState() => _AnimatedBorderCircleState();
}

class _AnimatedBorderCircleState extends State<AnimatedBorderCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: CircleBorderPainter(_controller.value),
            child: Container(
              // margin: EdgeInsets.all(20),
              // padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/logo_w.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.66,
              height: MediaQuery.of(context).size.height * 0.3,
              // alignment: Alignment.center,
            ),
          );
        },
      ),
    );
  }
}

class CircleBorderPainter extends CustomPainter {
  final double progress;
  CircleBorderPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final startAngle = 2 * math.pi * progress;

    final Paint paint = Paint()
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: 2 * math.pi,
        colors: [kMainColor, Colors.white, kMainDarkColor],
        stops: [0.0, 0.5, 1.0],
        transform: GradientRotation(startAngle),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;

    final radius = size.width / 2 - 6;
    canvas.drawCircle(size.center(Offset.zero), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
