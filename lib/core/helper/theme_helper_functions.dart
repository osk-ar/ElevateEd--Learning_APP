import 'dart:ui';

bool isLightTheme() {
  final brightness = PlatformDispatcher.instance.platformBrightness;
  if (brightness == Brightness.light) {
    return true;
  } else {
    return false;
  }
}
