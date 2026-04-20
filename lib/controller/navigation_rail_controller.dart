// Package imports:
import 'package:get/get.dart';

class NavigationRailController extends GetxController {
  RxBool isNavExpanded = true.obs;

  double get normalWidth => 50;

  double get expandedWidth => 230;

  Duration animationDuration = Duration(milliseconds: 250);

  // Toggle extended in navigation rail widget
  void toggleNavigationRail() {
    isNavExpanded.value = !isNavExpanded.value;
  }
}
