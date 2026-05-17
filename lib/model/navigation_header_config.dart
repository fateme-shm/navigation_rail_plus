import 'package:flutter/material.dart';

/// Configuration for the header section of the navigation rail.
///
/// This controls how the top area of the navigation component is rendered,
/// including custom header widgets, fallback icons, and toggle behavior.

class NavigationHeaderConfig {
  /// Custom widget rendered at the top of the navigation component.
  /// Takes priority over [headerIcon] when provided.
  final Widget? header;

  /// Fallback icon displayed in the header when [header] is not provided,
  /// or used in collapsed mode.
  final Widget? headerIcon;

  /// Size applied to [headerIcon] when rendered.
  final double? headerIconSize;

  /// Color applied to [headerIcon].
  final Color? headerIconColor;

  /// Divider color under header
  final Color? dividerColor;

  /// Divider under header
  final bool needHeaderDivider;

  /// Icon used to toggle between expanded and collapsed rail states.
  final Icon? toggleNavigationIcon;

  NavigationHeaderConfig({
    this.header,
    this.headerIcon,
    this.headerIconSize,
    this.headerIconColor,
    this.toggleNavigationIcon,
    this.dividerColor,
    this.needHeaderDivider = false,
  });
}
