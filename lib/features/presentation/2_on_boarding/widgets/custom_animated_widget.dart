import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/core/constants/app_assets.dart';
import 'package:ElevatED/features/presentation/2_on_boarding/widgets/floating_text_container.dart';
import 'package:ElevatED/features/presentation/2_on_boarding/widgets/image_container.dart';
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
    const double verticalBeginOffset = 10;
    const double horizontalBeginOffset = 10;
    const double verticalEndOffset = -30;
    const double horizontalEndOffset = 10;
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            AnimatedFloatingContainer(
              text: AppStrings.mentoring,
              beginAngle: 0.2,
              endAngle: -0.2,
              beginOffset: Offset((horizontalBeginOffset - 100).w,
                  (verticalBeginOffset + 90).h),
              endOffset: Offset(
                  (horizontalEndOffset - 120).w, (verticalEndOffset - 90).h),
              textColor: AppColors.darkSecondaryColor,
              backgroundColor: AppColors.whiteColor,
              floatingDuration: widget.textFloatingLoopDuration - 100,
            ),
            AnimatedFloatingContainer(
              text: AppStrings.improvement,
              beginAngle: -0.2,
              endAngle: 0.4,
              beginOffset: Offset(
                  (horizontalBeginOffset - 20).w, (verticalBeginOffset + 90).h),
              endOffset: Offset(
                  (horizontalEndOffset - 20).w, (verticalEndOffset - 150).h),
              textColor: AppColors.whiteColor,
              backgroundColor: AppColors.darkSecondaryColor,
              floatingDuration: widget.textFloatingLoopDuration + 50,
            ),
            AnimatedFloatingContainer(
              text: AppStrings.levelUp,
              beginAngle: 0,
              endAngle: -0.3,
              beginOffset: Offset(
                  (horizontalBeginOffset - 80).w, (verticalBeginOffset + 90).h),
              endOffset: Offset(
                  (horizontalEndOffset + 70).w, (verticalEndOffset - 80).h),
              textColor: AppColors.darkSecondaryColor,
              backgroundColor: AppColors.whiteColor,
              floatingDuration: widget.textFloatingLoopDuration + 100,
            ),
            AnimatedFloatingContainer(
              text: AppStrings.course,
              beginAngle: 0,
              endAngle: 0.3,
              beginOffset: Offset(
                  (horizontalBeginOffset + 80).w, (verticalBeginOffset + 90).h),
              endOffset: Offset(
                  (horizontalEndOffset + 80).w, (verticalEndOffset - 10).h),
              textColor: AppColors.whiteColor,
              backgroundColor: AppColors.darkSecondaryColor,
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
