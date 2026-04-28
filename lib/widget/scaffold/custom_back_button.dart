import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navigation_rail_plus/res/context_extension.dart';


class CustomBackButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget? icon;
  final Color? iconColor;

  const CustomBackButton({
    super.key,
    required this.onTap,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    // Check platform to determine back button style
    return context.appTheme.platform == TargetPlatform.iOS || kIsWeb
        ? IconButton(
            onPressed: onTap,
            icon:
                icon ??
                Icon(
                  // Cupertino-style back arrow
                  size: context.largeIcon,
                  Icons.arrow_back_ios,
                  color: iconColor,
                ),
          )
        : IconButton(
            icon:
                icon ??
                Icon(
                  // Material-style back arrow
                  size: context.largeIcon,
                  Icons.arrow_back,
                  color: iconColor,
                ),
            // If no onTap provided, fallback to Navigator.pop
            onPressed: onTap,
          );
  }
}
