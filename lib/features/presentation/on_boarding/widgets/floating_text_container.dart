import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:flutter/material.dart';

class AnimatedFloatingContainer extends StatefulWidget {
  const AnimatedFloatingContainer(
      {super.key,
      required this.text,
      required this.beginOffset,
      required this.endOffset,
      required this.beginAngle,
      required this.endAngle,
      required this.movementCurve,
      required this.rotationCurve,
      required this.backgroundColor,
      required this.textColor,
      required this.floatingDistance,
      required this.animationDuration,
      required this.floatingDuration});
  final String text;
  final Offset beginOffset;
  final Offset endOffset;
  final Curve movementCurve;
  final double beginAngle;
  final double endAngle;
  final Curve rotationCurve;
  final Color backgroundColor;
  final Color textColor;
  final double floatingDistance;
  final int animationDuration;
  final int floatingDuration;
  @override
  AnimatedFloatingContainerState createState() =>
      AnimatedFloatingContainerState();
}

class AnimatedFloatingContainerState extends State<AnimatedFloatingContainer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _floatingController;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<Offset> _floatingAnimation;

  @override
  void initState() {
    super.initState();

    //*-------------------------------------- declaring controllers

    _controller = AnimationController(
      duration: Duration(milliseconds: widget.animationDuration),
      vsync: this,
    );

    _floatingController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.floatingDuration),
    );

    //*-------------------------------------- declaring animations

    _positionAnimation = Tween<Offset>(
      begin: widget.beginOffset,
      end: widget.endOffset,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.movementCurve,
    ));

    _rotationAnimation = Tween<double>(
      begin: widget.beginAngle,
      end: widget.endAngle,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.rotationCurve,
    ));

    _floatingAnimation = Tween<Offset>(
      begin: widget.endOffset,
      end: widget.endOffset.translate(0, widget.floatingDistance),
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.linear,
    ));

    //*-------------------------------------- Starting animations

    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _floatingController.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: Listenable.merge([_controller, _floatingController]),
        builder: (context, child) {
          return Transform.translate(
            offset: _controller.status.isCompleted
                ? _floatingAnimation.value
                : _positionAnimation.value,
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(36),
                ),
                child: Text(
                  widget.text,
                  style: AppTextStyles.mediumTextStyle(context,
                      fontSize: 16, color: widget.textColor),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
