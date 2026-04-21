// Package imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/global_config.dart';

class NavigationController extends GetxController {
  // Handle expanded variable
  RxBool isNavExpanded = true.obs;

  final GlobalConfig globalConfig = GlobalConfig();

  final ScrollController scrollController = ScrollController();

  // Find navigation rail controller
  NavigationController findNavigationRailController() {
    return Get.find(tag: globalConfig.navRailControllerKey);
  }

  // Toggle extended in navigation rail widget
  void toggleNavigationRail() {
    isNavExpanded.value = !isNavExpanded.value;
  }

  void disposeVariable() {
    scrollController.dispose();
  }
}
