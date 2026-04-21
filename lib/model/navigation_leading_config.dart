import 'package:flutter/material.dart';
import 'package:navigation_rail_plus/model/custom_navigation_rail_destination.dart';

/// Configuration for navigation leading items (main navigation section).
///
/// This includes styling, behavior, and the list of navigation destinations
/// displayed in the [NavigationRailMode.rail] or [NavigationRailMode.drawer].
///

class NavigationLeadingConfig {
  /// Default color for navigation item icons and labels.
  final Color? leadingColor;

  /// Background color applied when a navigation item is hovered.
  final Color? leadingHoverColor;

  /// Color applied to the selected navigation item.
  final Color? selectedLeadingColor;

  /// Icon size used for navigation items.
  final double? leadingIconSize;

  /// Padding applied around each navigation item.
  final EdgeInsets? leadingIconPadding;

  /// Whether tooltips are shown for navigation items,
  /// especially useful in collapsed rail mode.
  final bool needTooltip;

  /// List of fixed navigation destinations (always visible, non-scrollable).
  final List<CustomNavigationRailDestination> fixLeadingItems;

  /// Optional list of additional navigation destinations
  /// displayed inside a scrollable container.
  final List<CustomNavigationRailDestination>? scrollableLeadingItems;

  NavigationLeadingConfig({
    required this.fixLeadingItems,
    this.leadingColor,
    this.leadingIconSize,
    this.leadingHoverColor,
    this.leadingIconPadding,
    this.selectedLeadingColor,
    this.scrollableLeadingItems,
    this.needTooltip = true,
  });
}
