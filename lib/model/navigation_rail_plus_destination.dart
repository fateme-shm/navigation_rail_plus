import 'package:flutter/material.dart';

/// Represents a single destination item in the custom navigation rail.
///
/// Each destination defines an icon, optional selected icon, label,
/// and an optional disabled state to control interaction.
class NavigationRailPlusDestination {
  /// Default icon shown when the item is not selected.
  final IconData icon;

  /// Icon shown when the item is selected.
  ///
  /// If null, [icon] will be used in both states.
  final IconData? selectedIcon;

  /// Text label displayed next to the icon in expanded mode.
  final String label;

  /// Whether this destination is interactive.
  ///
  /// If true, the item is visually disabled and cannot be selected.
  final bool disabled;

  /// Creates a navigation rail destination item.
  const NavigationRailPlusDestination({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.disabled = false,
  });
}