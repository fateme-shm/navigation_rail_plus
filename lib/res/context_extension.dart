import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:navigation_rail_plus/res/utils/color_scheme.dart';
import 'package:navigation_rail_plus/res/utils/screen_utils.dart';

extension CustomExtensions on BuildContext {
  /// Returns the full height of the current screen.
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Returns the current screen width, limited to a maximum of 500.
  double get screenWidth {
    double width = MediaQuery.of(this).size.width;
    return width;
  }

  /// An extension on [BuildContext] that provides quick access
  /// to commonly used theme properties such as [TextTheme] and [ColorScheme].
  ///
  /// This helps reduce boilerplate by allowing you to write:
  /// ```dart
  /// context.textTheme.bodyLarge
  /// context.colorScheme.primary
  /// ```
  ThemeData get appTheme => Theme.of(this);

  TextTheme get appTextTheme => Theme.of(this).textTheme;

  ColorScheme get appColorScheme => Theme.of(this).colorScheme;

  BottomSheetThemeData get bottomSheetTheme => BottomSheetThemeData(
    elevation: 0,
    backgroundColor: Color.alphaBlend(
      Get.isDarkMode
          ? darkColorScheme.secondaryContainer.withValues(alpha: 0.3)
          : lightColorScheme.secondaryContainer.withValues(alpha: 0.3),
      Get.isDarkMode ? darkColorScheme.surface : lightColorScheme.surface,
    ),
    constraints: const BoxConstraints(maxWidth: 500),
  );

  // Icon size extensions
  double get smallIcon {
    switch (screenType) {
      case DeviceScreenType.mobile:
        return 14;
      case DeviceScreenType.tablet:
      case DeviceScreenType.desktop:
        return 16;
    }
  }

  double get mediumIcon {
    switch (screenType) {
      case DeviceScreenType.mobile:
        return 18;
      case DeviceScreenType.tablet:
      case DeviceScreenType.desktop:
        return 20;
    }
  }

  double get largeIcon {
    switch (screenType) {
      case DeviceScreenType.mobile:
        return 22;
      case DeviceScreenType.tablet:
      case DeviceScreenType.desktop:
        return 24;
    }
  }
}
