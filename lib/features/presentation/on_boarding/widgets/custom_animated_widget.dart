import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/resources/assets_manager.dart';
import 'package:e_learning_app_gp/features/presentation/on_boarding/widgets/floating_text_container.dart';
import 'package:e_learning_app_gp/features/presentation/on_boarding/widgets/image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAnimatedWidget extends StatefulWidget {
  const CustomAnimatedWidget({super.key});
  // Durations in Milliseconds
  final int imageAnimationDuration = 700;
  final int textAnimationDuration = 2000;
  final int textFloatingLoopDuration = 1400;

  @override
  State<CustomAnimatedWidget> createState() => _CustomAnimatedWidgetState();
}

class _CustomAnimatedWidgetState extends State<CustomAnimatedWidget> {
  late double imagesRotationAngle;
  late double imagesAnimationDistance;
  final AssetImage _laptopImage =
      const AssetImage(ImageAssets.onBoarding_laptop);
  final AssetImage _uiuxImage = const AssetImage(ImageAssets.onBoarding_uiux);

  @override
  void initState() {
    super.initState();
    imagesRotationAngle = 0;
    imagesAnimationDistance = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animateRotationAndPosition();
    });
  }

  void _animateRotationAndPosition() {
    setState(() {
      imagesRotationAngle += 0.15;
      imagesAnimationDistance += 40.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            AnimatedFloatingContainer(
              text: "#Mentoring",
              beginAngle: 0.2,
              endAngle: -0.2,
              beginOffset: Offset(-100.w, 100.h),
              endOffset: Offset(-120.w, -90.h),
              backgroundColor: MyTheme.textColor,
              textColor: MyTheme.inverseTextColor,
              floatingDuration: widget.textFloatingLoopDuration - 100,
            ),
            AnimatedFloatingContainer(
              text: "#Improvement",
              beginAngle: -0.2,
              endAngle: 0.4,
              beginOffset: Offset(-10.w, 100.h),
              endOffset: Offset(-10.w, -150.h),
              backgroundColor: MyTheme.inverseTextColor,
              textColor: MyTheme.textColor,
              floatingDuration: widget.textFloatingLoopDuration + 50,
            ),
            AnimatedFloatingContainer(
              text: "#LevelUp",
              beginAngle: 0,
              endAngle: -0.3,
              beginOffset: Offset(80.w, 100.h),
              endOffset: Offset(80.w, -80.h),
              backgroundColor: MyTheme.textColor,
              textColor: MyTheme.inverseTextColor,
              floatingDuration: widget.textFloatingLoopDuration + 100,
            ),
            AnimatedFloatingContainer(
              text: "#Course",
              beginAngle: 0,
              endAngle: 0.3,
              beginOffset: Offset(90.w, 100.h),
              endOffset: Offset(90.w, 0.h),
              backgroundColor: MyTheme.inverseTextColor,
              textColor: MyTheme.textColor,
              floatingDuration: widget.textFloatingLoopDuration - 50,
            ),
            Positioned(
              left: 20.w,
              child: ImageContainer(
                image: _uiuxImage,
                size: Size(200.w, 270.h),
                animationDuration: widget.imageAnimationDuration,
                rotationAngle: -imagesRotationAngle,
                positionDistance: imagesAnimationDistance,
              ),
            ),
            Positioned(
              right: 20.w,
              child: ImageContainer(
                image: _laptopImage,
                size: Size(200.w, 170.h),
                animationDuration: widget.imageAnimationDuration,
                rotationAngle: imagesRotationAngle,
                positionDistance: imagesAnimationDistance,
              ),
            ),
          ],
        ),
      ),
    );
  }
}




//? 1- create the images widget
//? 2- animate the images
/// 3- create the text widget
/// 4- animate the text
