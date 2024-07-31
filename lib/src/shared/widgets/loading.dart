import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rawdat_hufaz/src/shared/themes/palette.dart';

class CustomLoadingIndicator extends StatefulWidget {
  const CustomLoadingIndicator({super.key});

  @override
  _CustomLoadingIndicatorState createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animation = Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CustomPaint(
          painter: CustomLoadingIndicatorPainter(_animation.value),
        ),
      ),
    );
  }
}

class CustomLoadingIndicatorPainter extends CustomPainter {
  final double angle;

  CustomLoadingIndicatorPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 1.8;
    const double ballRadius = 10;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    for (int i = 0; i < 4; i++) {
    final Paint paint = Paint()..color = i%2==1? Palette.darkOlive:Palette.lightPrimaryColor;

      double currentAngle = angle + (i * pi / 2);
      double x = centerX + (radius - ballRadius) * cos(currentAngle);
      double y = centerY + (radius - ballRadius) * sin(currentAngle);
      canvas.drawCircle(Offset(x, y), ballRadius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

