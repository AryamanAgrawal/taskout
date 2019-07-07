import 'package:flutter/material.dart';
import 'dart:math' as Math;

class CircleProgressBar extends StatefulWidget {
  final Duration animationDuration;
  final Color backgroundColor;
  final Color foregroundColor;
  final double value;

  const CircleProgressBar({
    Key key,
    this.animationDuration,
    this.backgroundColor,
    this.foregroundColor,
    @required this.value,
  }) : super(key: key);

  @override
  CircleProgressBarState createState() {
    return CircleProgressBarState();
  }
}

class CircleProgressBarState extends State<CircleProgressBar>
    with SingleTickerProviderStateMixin {
  static const TRANSPARENT = Color(0x00000000);
  AnimationController _controller;
  Animation<double> curve;
  Tween<double> valueTween;
  Tween<Color> backgroundColorTween;
  Tween<Color> foregroundColorTween;

  @override
  void initState() {
    super.initState();

    this._controller = AnimationController(
      duration: this.widget.animationDuration ?? const Duration(seconds: 1),
      vsync: this,
    );

    this.curve = CurvedAnimation(
      parent: this._controller,
      curve: Curves.easeInOut,
    );

    this.valueTween = Tween<double>(
      begin: 0,
      end: this.widget.value,
    );

    this._controller.forward();
    if (widget.value > 0.5) {
      this.foregroundColorTween = ColorTween(
        begin: Color(0xff4A69FF),
        end: Color(0xff4AD284),
      );
    }else{
      this.foregroundColorTween = null;
    }
  }

  @override
  void didUpdateWidget(CircleProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (this.widget.value != oldWidget.value) {
      double beginValue =
          this.valueTween?.evaluate(this.curve) ?? oldWidget?.value ?? 0;

      this.valueTween = Tween<double>(
        begin: beginValue,
        end: this.widget.value ?? 1,
      );

      if (oldWidget?.backgroundColor != this.widget.backgroundColor) {
        this.backgroundColorTween = ColorTween(
          begin: oldWidget?.backgroundColor ?? TRANSPARENT,
          end: this.widget.backgroundColor ?? TRANSPARENT,
        );
      } else {
        this.backgroundColorTween = null;
      }

      /*if (oldWidget.foregroundColor != this.widget.foregroundColor) {
        this.foregroundColorTween = ColorTween(
          begin: oldWidget?.foregroundColor,
          end: this.widget.foregroundColor,
        );
      } else {
        this.foregroundColorTween = null;
      }*/

      this._controller
        ..value = 0
        ..forward();
    }
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedBuilder(
        animation: this.curve,
        child: Container(),
        builder: (context, child) {
          final backgroundColor =
              this.backgroundColorTween?.evaluate(this.curve) ??
                  this.widget.backgroundColor;
          final foregroundColor =
              this.foregroundColorTween?.evaluate(this.curve) ??
                  this.widget.foregroundColor;

          return CustomPaint(
            child: child,
            foregroundPainter: CircleProgressBarPainter(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              percentage: this.valueTween.evaluate(this.curve),
            ),
          );
        },
      ),
    );
  }
}

class CircleProgressBarPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color backgroundColor;
  final Color foregroundColor;

  CircleProgressBarPainter({
    this.backgroundColor,
    @required this.foregroundColor,
    @required this.percentage,
    double strokeWidth,
  }) : this.strokeWidth = strokeWidth ?? 6;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final Size constrainedSize =
        size - Offset(this.strokeWidth, this.strokeWidth);
    final shortestSide =
        Math.min(constrainedSize.width, constrainedSize.height);
    final foregroundPaint = Paint()
      ..color = this.foregroundColor
      ..strokeWidth = this.strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final radius = (shortestSide / 2);

    final double startAngle = -(2 * Math.pi * 0.25);
    final double sweepAngle = (2 * Math.pi * (this.percentage ?? 0));

    if (this.backgroundColor != null) {
      final backgroundPaint = Paint()
        ..color = this.backgroundColor
        ..strokeWidth = this.strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, backgroundPaint);
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as CircleProgressBarPainter);
    return oldPainter.percentage != this.percentage ||
        oldPainter.backgroundColor != this.backgroundColor ||
        oldPainter.foregroundColor != this.foregroundColor ||
        oldPainter.strokeWidth != this.strokeWidth;
  }
}
