import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Navigation on BuildContext {
  pop() => Navigator.of(this).pop();

  pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }
}

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;

  double get topPadding => MediaQuery.of(this).viewPadding.top;

  double get bottom => MediaQuery.of(this).viewInsets.bottom;
}

extension SnakBar on BuildContext {
  void message({
    required String message,
    Color? color,
    Color? textColor,
    Duration? duration,
  }) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            message,
            style: TextStyle(color: textColor ?? AppColors.whiteColor),
          ),
          backgroundColor: color ?? AppColors.onSurfaceColor,
          duration: duration ?? const Duration(seconds: 4),
        ),
      );
}

extension BottomSheet on BuildContext {
  void bottomSheet({required Widget child}) => showModalBottomSheet(
        context: this,
        backgroundColor: ThemeColors.lightSurfaceToDarkSecondary,
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        builder: (context) {
          return SizedBox(
            height: 443.h,
            child: Scaffold(backgroundColor: Colors.transparent, body: child),
          );
        },
      );
}

// extension Dialog on BuildContext {
//   Future<void> showCustomDialog({
//     required String title,
//     required String content,
//     required String confirmButtonText,
//     required VoidCallback onConfirmPressed,
//     required String cancelButtonText,
//     required VoidCallback onCancelPressed,
//   }) {
//     return showDialog(
//       context: this,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(content),
//           actionsAlignment: MainAxisAlignment.spaceAround,
//           actions: [
//             TextButton(
//               onPressed: onCancelPressed,
//               child: Text(cancelButtonText),
//             ),
//             TextButton(
//               onPressed: onConfirmPressed,
//               child: Text(confirmButtonText),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

extension ColorTheme on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;

  Color get darkPrimaryColor => Theme.of(this).primaryColorDark;

  Color get primaryColorScheme => Theme.of(this).colorScheme.primary;

  Color get secondaryColorScheme => Theme.of(this).colorScheme.secondary;

  Color get tertiaryColorScheme => Theme.of(this).colorScheme.tertiary;
}

extension StringExtension on String? {
  RegExp get containsLink {
    return RegExp(
      r'((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?([a-z0-9]+([-\.]{1}[a-z0-9]+)*\.[a-z]{2,5})(:[0-9]{1,5})?(\/\S*)?)',
      caseSensitive: false,
      multiLine: true,
    );
  }

  bool isNullOrEmpty() => this == null || this!.isEmpty || this == '';
}
