import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlobalConfig {
  String navRailControllerKey = 'nav_rail_controller';

  EdgeInsets globalMargin = const EdgeInsets.symmetric(horizontal: 4);

  BorderRadius globalBorderRadius = BorderRadius.circular(4);

  EdgeInsets symmetricMargin = const EdgeInsets.symmetric(
    vertical: 2,
    horizontal: 4,
  );
}

/// Returns a [SystemUiOverlayStyle] based on the current theme brightness.
///
/// This function determines the appropriate status bar icon brightness and status
/// bar brightness to use, depending on whether the app's theme is light or dark.
///
/// The [context] parameter is required to access the theme data.
SystemUiOverlayStyle getSystemOverlayStyle({required BuildContext context}) {
  SystemUiOverlayStyle systemOverlayStyle = SystemUiOverlayStyle(
    statusBarIconBrightness: Theme.of(context).brightness == Brightness.light
        ? Brightness.dark
        : Brightness.light,
    statusBarBrightness: Theme.of(context).brightness,
  );
  return systemOverlayStyle;
}
