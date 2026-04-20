// Flutter imports:
import 'package:flutter/material.dart';

class CustomNavigationRailDestination {
  final IconData icon;
  final IconData? selectedIcon;

  final String label;
  final bool disabled;

  const CustomNavigationRailDestination({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.disabled = false,
  });
}
