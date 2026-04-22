import 'package:flutter/material.dart';
import 'package:navigation_rail_plus/navigation_rail_plus.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Rail Plus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: context.appColorScheme.primary,
        ),
      ),
      home: const ManualDrawer(),
    );
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

class AutomaticNavigationRail extends StatefulWidget {
  const AutomaticNavigationRail({super.key});

  @override
  State<AutomaticNavigationRail> createState() =>
      _AutomaticNavigationRailState();
}

class _AutomaticNavigationRailState extends State<AutomaticNavigationRail> {
  int _selectedIndex = 0;

  void _handleOnDestination(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget get _buildPage {
    switch (_selectedIndex) {
      case 0:
        return Center(child: Text('Home Page'));
      case 1:
        return Center(child: Text('Category Page'));
      case 2:
        return Center(child: Text('Profile Page'));
      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavigationRailPlus(
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
        navigationGlobalConfig: NavigationGlobalConfig(
          drawerWidth: context.screenWidth * 0.8,
          backgroundColor: context.appColorScheme.surfaceContainerLowest,
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
                children: [
                  Text('Item ${index + 1}'),
                  const SizedBox(height: 15),
                ],
              );
            },
          ),
          // Any other widget you want
        ],
        responsiveBody: _buildPage,
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
      ),
    );
  }
}
