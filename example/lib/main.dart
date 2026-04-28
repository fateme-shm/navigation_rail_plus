import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:navigation_rail_plus/navigation_rail_plus.dart';


void main() {
  runApp(const MyApp());
}

class AppController extends GetxController {
  var selectedIndex = 0.obs;
  var isLoading = false.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> refreshData() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NavigationRailPlus Advanced Example',
      home: const ManualNavigationRail(),
    );
  }
}

class AutomaticNavigationRail extends StatelessWidget {
  const AutomaticNavigationRail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppController());

    return Obx(() {
      return NavigationRailPlus(

        /// ----------------------------
        /// Navigation Config
        /// ----------------------------
        selectedIndex: controller.selectedIndex.value,
        onDestinationSelected: controller.changeIndex,

        navigationHeaderConfig: NavigationHeaderConfig(header: Text('My App')),

        navigationLeadingConfig: NavigationLeadingConfig(
          fixLeadingItems: [
            NavigationRailPlusDestination(
              label: 'Home',
              icon: Icons.home_outlined,
              selectedIcon: Icons.home,
            ),
            NavigationRailPlusDestination(
              label: 'Search',
              icon: Icons.search_outlined,
              selectedIcon: Icons.search,
            ),
          ],
          scrollableLeadingItems: [
            NavigationRailPlusDestination(
              label: 'Profile',
              icon: Icons.person_outline,
              selectedIcon: Icons.person,
            ),
            NavigationRailPlusDestination(
              label: 'Settings',
              icon: Icons.settings_outlined,
              selectedIcon: Icons.settings,
            ),
          ],
        ),

        navigationFooterConfig: NavigationFooterConfig(
          footer: const Padding(
            padding: EdgeInsets.all(12),
            child: Text('Footer Section'),
          ),
        ),

        navigationGlobalConfig: NavigationGlobalConfig(
          responsiveLayout: true,
          backgroundColor: Colors.grey.shade50,
        ),

        /// ----------------------------
        /// AppBar
        /// ----------------------------
        appBarText: 'Dashboard',
        appBarCenterTitle: true,
        appBarBottomRxLoading: controller.isLoading,
        appBarActions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshData,
          ),
        ],

        /// ----------------------------
        /// Body
        /// ----------------------------
        responsiveBody: _buildPage(controller.selectedIndex.value),

        navigationMainContent: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: 30,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, i) =>
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('Item ${i + 1}'), const SizedBox(height: 12)],
                ),
          ),
        ],

        /// ----------------------------
        /// Extra UI Features
        /// ----------------------------
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.snackbar('FAB', 'Clicked'),
          child: const Icon(Icons.add),
        ),

        bottomSheet: Container(
          height: 60,
          color: Colors.black12,
          alignment: Alignment.center,
          child: const Text('Bottom Sheet'),
        ),

        onRefresh: controller.refreshData,
      );
    });
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return _page('Home Page');
      case 1:
        return _page('Search Page');
      case 2:
        return _page('Profile Page');
      case 3:
        return _page('Settings Page');
      default:
        return const SizedBox();
    }
  }

  Widget _page(String title) {
    return Center(child: Text(title));
  }
}

class ManualNavigationRail extends StatefulWidget {
  const ManualNavigationRail({super.key});

  @override
  State<ManualNavigationRail> createState() => _ManualNavigationRailState();
}

class _ManualNavigationRailState extends State<ManualNavigationRail> {
  int _selectedIndex = 0;

  void _handleOnDestination(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildNavigationRailPlus,
          VerticalDivider(thickness: 1, width: 0),
          Expanded(child: Column(children: [])),
        ],
      ),
    );
  }

  Widget get _buildNavigationRailPlus {
    return NavigationRailPlus(
      navigationHeaderConfig: NavigationHeaderConfig(header: Text('Header')),
      selectedIndex: _selectedIndex,
      navigationLeadingConfig: NavigationLeadingConfig(
        fixLeadingItems: [
          NavigationRailPlusDestination(
            label: 'Home',
            icon: Icons.home_outlined,
            selectedIcon: Icons.home,
          ),
          NavigationRailPlusDestination(
            label: 'Category',
            icon: Icons.category_outlined,
            selectedIcon: Icons.category,
          ),
        ],
        scrollableLeadingItems: [
          NavigationRailPlusDestination(
            label: 'Profile',
            icon: Icons.person_outline,
            selectedIcon: Icons.person,
          ),
        ],
      ),
      onDestinationSelected: (index) {
        _handleOnDestination(index);
      },
      navigationMainContent: [
        ListView.builder(
          itemCount: 50,
          padding: GlobalConfig().globalMargin * 4,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: .start,
              children: [Text('Item ${index + 1}'), const SizedBox(height: 15)],
            );
          },
        ),
        // Any other widget you want
      ],
      navigationFooterConfig: NavigationFooterConfig(
        footer: Text('This is footer section.'),
        trailing: Column(
          children: [
            Divider(
              height: 0,
              thickness: 0.5,
              color: context.appColorScheme.outlineVariant,
            ),
            const SizedBox(height: 12),
            Text('This is trailing.'),
          ],
        ),
      ),
      navigationGlobalConfig: NavigationGlobalConfig(
        responsiveLayout: false,
        mode: NavigationRailMode.rail,
        backgroundColor: context.appColorScheme.surfaceContainerLowest,
      ),
    );
  }
}

class ManualDrawer extends StatefulWidget {
  const ManualDrawer({super.key});

  @override
  State<ManualDrawer> createState() => _ManualDrawerState();
}

class _ManualDrawerState extends State<ManualDrawer> {
  int _selectedIndex = 0;

  void _handleOnDestination(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drawer example')),
      drawer: _buildDrawer,
    );
  }

  Widget get _buildDrawer {
    return NavigationRailPlus(
      navigationHeaderConfig: NavigationHeaderConfig(header: Text('Header')),
      selectedIndex: _selectedIndex,
      navigationLeadingConfig: NavigationLeadingConfig(
        fixLeadingItems: [
          NavigationRailPlusDestination(
            label: 'Home',
            icon: Icons.home_outlined,
            selectedIcon: Icons.home,
          ),
          NavigationRailPlusDestination(
            label: 'Category',
            icon: Icons.category_outlined,
            selectedIcon: Icons.category,
          ),
        ],
        scrollableLeadingItems: [
          NavigationRailPlusDestination(
            label: 'Profile',
            icon: Icons.person_outline,
            selectedIcon: Icons.person,
          ),
        ],
      ),
      onDestinationSelected: (index) {
        _handleOnDestination(index);
      },
      navigationMainContent: [
        ListView.builder(
          itemCount: 50,
          padding: GlobalConfig().globalMargin * 4,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: .start,
              children: [Text('Item ${index + 1}'), const SizedBox(height: 15)],
            );
          },
        ),
        // Any other widget you want
      ],
      navigationFooterConfig: NavigationFooterConfig(
        footer: Text('This is footer section.'),
        trailing: Column(
          children: [
            Divider(
              height: 0,
              thickness: 0.5,
              color: context.appColorScheme.outlineVariant,
            ),
            const SizedBox(height: 12),
            Text('This is trailing.'),
          ],
        ),
      ),
      navigationGlobalConfig: NavigationGlobalConfig(
        responsiveLayout: false,
        mode: NavigationRailMode.drawer,
        drawerWidth: context.screenWidth * 0.8,
        backgroundColor: context.appColorScheme.surfaceContainerLowest,
      ),
    );
  }
}

