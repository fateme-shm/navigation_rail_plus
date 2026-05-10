import 'package:flutter/material.dart';
import 'package:navigation_rail_plus/enums/navigation_rail_mode.dart';

/// Global configuration for the navigation rail system.
///
/// This class controls high-level behavior such as layout mode,
/// responsiveness, sizing, animation timing, and general container styling.
///

class NavigationGlobalConfig {
  /// Enables automatic responsive behavior:
  /// switches between rail and drawer based on screen size.
  final bool responsiveLayout;

  /// Duration used for expand/collapse and implicit animations.
  final Duration? animationDuration;

  /// Defines the navigation presentation mode (rail or drawer).
  final NavigationRailMode mode;

  /// Explicit width of the drawer when [mode] is drawer.
  final double? drawerWidth;

  /// Explicit width of the EndDrawer when [mode] is end drawer.
  final double? endDrawerWidth;

  /// Width of the navigation rail in collapsed state.
  final double collapsedRailWidth;

  /// Width of the navigation rail in expanded state.
  final double expandedRailWidth;

  /// Forces a fixed layout size, disabling dynamic resizing behavior.
  final bool needFixedSize;

  /// Whether the drawer should automatically close after selecting an item.
  final bool closeOnSelectDrawerItem;

  /// Background color of the navigation container.
  final Color? backgroundColor;

  NavigationGlobalConfig({
    this.backgroundColor,

    this.drawerWidth,
    this.endDrawerWidth,

    this.collapsedRailWidth = 50,
    this.expandedRailWidth = 250,

    this.animationDuration,

    this.needFixedSize = false,
    this.responsiveLayout = true,
    this.closeOnSelectDrawerItem = true,

    this.mode = NavigationRailMode.rail,
  });
}
