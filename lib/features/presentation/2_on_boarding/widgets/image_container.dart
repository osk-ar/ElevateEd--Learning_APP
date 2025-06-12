import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final AssetImage image;
  final Size size;
  final int animationDuration;
  final double rotationAngle;
  final double positionDistance;
  const ImageContainer(
      {super.key,
      required this.size,
      required this.rotationAngle,
      required this.positionDistance,
      required this.animationDuration,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: animationDuration),
      curve: Curves.easeOutQuint,
      transform: Matrix4.rotationZ(rotationAngle),
      transformAlignment: Alignment.center,
      margin: EdgeInsets.only(bottom: positionDistance),
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          )),
    );
  }
}
