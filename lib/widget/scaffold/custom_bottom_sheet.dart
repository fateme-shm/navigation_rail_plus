import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:navigation_rail_plus/navigation_rail_plus.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.child,
    this.backgroundColor,
    this.paddingBottom,
  });

  final Widget child;
  final Color? backgroundColor;
  final double? paddingBottom;

  @override
  Widget build(BuildContext context) {
    GlobalConfig globalConfig = GlobalConfig();

    double bottom = 0;

    if (kIsWeb ||
        Platform.isAndroid ||
        MediaQuery.of(context).viewInsets.bottom > 0) {
      bottom = 20;
    } else {
      bottom = paddingBottom ?? 25;
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: globalConfig.globalBorderRadius.topLeft * 7,
          topRight: globalConfig.globalBorderRadius.topRight * 7,
        ),
      ),

      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        kIsWeb
            ? 20
            : Platform.isAndroid
            ? 20
            : bottom,
      ),
      width: context.screenWidth,
      child: Wrap(children: [child]),
    );
  }
}
