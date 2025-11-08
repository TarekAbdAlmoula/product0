import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product0/core/utils/constants.dart';

class AnimatedBorderCircle extends StatefulWidget {
  const AnimatedBorderCircle({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenMin = math.min(1.sw, 1.sh);
    double circleSize = screenMin * 0.6;
    double strokeWidth = circleSize * 0.02;

    return Center(
      child: SizedBox(
        width: circleSize,
        height: circleSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // الصورة
            ClipOval(
              child: Image.asset(
                'assets/images/logo_w.jpeg',
                width: circleSize,
                height: circleSize,
                fit: BoxFit.fill,
              ),
            ),
            // الحد الخارجي المتحرك
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: CircleBorderPainter(_controller.value, strokeWidth),
                  size: Size(circleSize, circleSize),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CircleBorderPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;

  CircleBorderPainter(this.progress, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final startAngle = 2 * math.pi * progress;

    final Paint paint = Paint()
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: 2 * math.pi,
        colors: [kMainColor, Colors.white, kMainDarkColor],
        stops: const [0.0, 0.5, 1.0],
        transform: GradientRotation(startAngle),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final radius = (size.width / 2) - strokeWidth / 2;
    canvas.drawCircle(size.center(Offset.zero), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
