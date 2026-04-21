import 'package:flutter/material.dart';

/// Configuration for footer and trailing sections of the navigation rail.
///
/// This class controls widgets displayed at the bottom area of the
/// navigation component in both expanded and collapsed states.
///

class NavigationFooterConfig {
  /// Widget displayed at the bottom in expanded state.
  final Widget? footer;

  /// Widget displayed at the bottom in collapsed state.
  final Widget? collapsedFooter;

  /// Widget displayed top of the footer in expanded state.
  final Widget? trailing;

  /// Widget displayed top of the footer in collapsed state.
  final Widget? collapsedTrailing;

  NavigationFooterConfig({
    this.footer,
    this.collapsedFooter,
    this.trailing,
    this.collapsedTrailing,
  });
}
