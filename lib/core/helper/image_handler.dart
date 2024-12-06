import 'dart:io';
import 'package:e_learning_app_gp/core/constants/constants.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/core/resources/app_values.dart';
import 'package:e_learning_app_gp/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImageManager extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const ImageManager({super.key, this.url, this.width, this.height, this.fit});

  @override
  Widget build(BuildContext context) {
    return _getImage(url);
  }

  Widget _getImage(String? url) {
    if (url.isNullOrEmpty() || url == Constants.url) {
      return Image.asset(ImageAssets.defaultImage);
    }

    if (url!.startsWith("http")) {
      return _networkImage(url);
    } else if (url.endsWith(".svg")) {
      return SvgPicture.asset(
        url,
        height: height?.r ?? AppSize.s48.r,
        width: width?.r ?? AppSize.s48.r,
        fit: fit ?? BoxFit.contain,
      );
    } else if (url.endsWith(".json") || url.endsWith(".gif")) {
      return Lottie.asset(
        url,
        height: height?.r ?? AppSize.s48.r,
        width: width?.r ?? AppSize.s48.r,
        fit: fit ?? BoxFit.contain,
      );
    } else if (url.contains('cache')) {
      return _cachedImage(url);
    } else {
      return Image.asset(
        url,
        height: height?.r ?? AppSize.s48.r,
        width: width?.r ?? AppSize.s48.r,
        fit: fit ?? BoxFit.contain,
      );
    }
  }

  Widget _networkImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height?.r ?? AppSize.s48.r,
      width: width?.r ?? AppSize.s48.r,
      fit: fit ?? BoxFit.contain,
      progressIndicatorBuilder: (context, url, progress) {
        return const Skeletonizer(enabled: true, child: SizedBox.shrink());
      },
    );
  }

  Widget _cachedImage(String path) {
    try {
      return Image.memory(
        File(path).readAsBytesSync(),
        height: height?.r ?? AppSize.s48.r,
        width: width?.r ?? AppSize.s48.r,
        fit: fit ?? BoxFit.contain,
      );
    } catch (e) {
      return Image.asset(
        ImageAssets.defaultImage,
        height: height?.r ?? AppSize.s48.r,
        width: width?.r ?? AppSize.s48.r,
        fit: fit ?? BoxFit.contain,
      );
    }
  }
}
