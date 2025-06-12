import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  const CustomStepper({
    super.key,
    required this.activeColor,
    required this.inActiveColor,
    required this.circleRadius,
    required this.lineThickness,
    required this.stepIcons,
    required this.groupIndex,
    required this.iconPadding,
  });

  final Color activeColor;
  final Color inActiveColor;
  final double circleRadius;
  final double lineThickness;
  final double iconPadding;
  final List<IconData> stepIcons;
  final int groupIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List<Widget>.generate((stepIcons.length * 2) - 1, (index) {
        return index.isEven
            ? PrayerStepperItem(
                radius: circleRadius,
                color: _getCircleColor(groupIndex, index),
                shouldFill: _shouldFillCircle(groupIndex, index),
                iconWidget: _getIconWidget(groupIndex, index),
              )
            : PrayerStepperLine(
                color: _getLineColor(groupIndex, index),
                thickness: lineThickness,
              );
      }),
    );
  }

  Color _getLineColor(int groupIndex, int index) {
    if (groupIndex > index ~/ 2) {
      return activeColor;
    } else {
      return inActiveColor;
    }
  }

  Color _getCircleColor(int groupIndex, int index) {
    if (groupIndex >= index ~/ 2) {
      return activeColor;
    } else {
      return inActiveColor;
    }
  }

  bool _shouldFillCircle(int groupIndex, int index) {
    return groupIndex * 2 >= index;
  }

  //? 2
  //? 2
  //? 2
  //? 2
  //? 2
  //? 2
  Widget _getIconWidget(int groupIndex, int index) {
    final Color color = index ~/ 2 > groupIndex ? inActiveColor : Colors.white;
    final IconData icon =
        index ~/ 2 < groupIndex ? Icons.check_rounded : stepIcons[index ~/ 2];
    return Icon(
      icon,
      size: (circleRadius * 2) - iconPadding,
      color: color,
    );
  }
}

class PrayerStepperLine extends StatelessWidget {
  const PrayerStepperLine({
    super.key,
    required this.color,
    required this.thickness,
  });
  final Color color;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomPaint(
        size: Size(double.infinity, thickness),
        willChange: false,
        painter: PrayerStepperLinePainter(
          color: color,
          thickness: thickness,
        ),
      ),
    );
  }
}

class PrayerStepperLinePainter extends CustomPainter {
  final Color color;
  final double thickness;
  PrayerStepperLinePainter({
    super.repaint,
    required this.color,
    required this.thickness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..color = color;

    canvas.drawLine(
      size.centerLeft(const Offset(2, 0)),
      size.centerRight(const Offset(-2, 0)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant PrayerStepperLinePainter oldDelegate) => false;
}

class PrayerStepperItem extends StatelessWidget {
  const PrayerStepperItem({
    super.key,
    required this.color,
    required this.radius,
    required this.shouldFill,
    required this.iconWidget,
  });
  final Color color;
  final double radius;
  final bool shouldFill;
  final Widget iconWidget;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size.square(radius * 2),
        painter: PrayerStepCirclePainter(
            radius: radius, color: color, shouldFill: shouldFill),
        child: iconWidget);
  }
}

class PrayerStepCirclePainter extends CustomPainter {
  final bool shouldFill;
  final Color color;
  final double radius;
  final double strokeWidth;
  PrayerStepCirclePainter({
    super.repaint,
    required this.radius,
    required this.color,
    required this.shouldFill,
    this.strokeWidth = 2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = shouldFill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;

    canvas.drawCircle(size.center(Offset.zero), radius, paint);
  }

  @override
  bool shouldRepaint(covariant PrayerStepCirclePainter oldDelegate) =>
      oldDelegate.shouldFill != shouldFill;
}
