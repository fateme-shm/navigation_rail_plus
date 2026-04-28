// Package imports:
import 'package:get/get.dart';

import '../res/global_config.dart';

class NavigationController {
  // Handle expanded variable
  RxBool isNavExpanded = true.obs;

  final GlobalConfig globalConfig = GlobalConfig();

  // Find navigation rail controller
  NavigationController findNavigationRailController() {
    return Get.find(tag: globalConfig.navRailControllerKey);
  }

  // Toggle extended in navigation rail widget
  void toggleNavigationRail() {
    isNavExpanded.value = !isNavExpanded.value;
  }
}
