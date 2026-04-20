// Flutter imports:
import 'package:flutter/material.dart';

enum DeviceScreenType { mobile, tablet, desktop }

extension ScreenType on BuildContext {
  DeviceScreenType get screenType {
    final width = MediaQuery.of(this).size.width;
    if (width >= ScreenBreakpoints.desktopMinWidth) {
      return DeviceScreenType.desktop;
    }
    if (width >= ScreenBreakpoints.mobileMaxWidth) {
      return DeviceScreenType.tablet;
    }
    return DeviceScreenType.mobile;
  }
}

// Mobile: ≤ 599px (covers most phones in portrait/landscape)
// Tablet: 600–1023px (7"–10" tablets, iPad, small laptops)
// Desktop: ≥ 1024px (desktops, large laptops)

/// Standard breakpoints (Material Design inspired)
class ScreenBreakpoints {
  static const double mobileMaxWidth = 600;
  static const double desktopMinWidth = 1024;
}
