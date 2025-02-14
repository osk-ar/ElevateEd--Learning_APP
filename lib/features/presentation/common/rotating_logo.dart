import 'dart:math';

import 'package:ElevatED/config/themes/theme.dart';
import 'package:ElevatED/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RotatingLogo extends StatefulWidget {
  final bool isInfiniteRotation;
  const RotatingLogo({super.key, required this.isInfiniteRotation});

  @override
  RotatingLogoState createState() => RotatingLogoState();
}

class RotatingLogoState extends State<RotatingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
          seconds: widget.isInfiniteRotation ? 5 : 3), // Slightly slower motion
    );

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.isInfiniteRotation
          ? Curves.linear
          : Curves.easeOutCubic, // Linear curve for infinite rotation
    ));

    if (widget.isInfiniteRotation) {
      _controller.repeat(); // Infinite rotation
    } else {
      _controller.forward(); // Start animation
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46.r,
      height: 46.r,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animation.value,
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                ThemeColors.inverseTextColor,
                BlendMode.srcIn,
              ),
              child: Image.asset(ImageAssets.logo, fit: BoxFit.contain),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
