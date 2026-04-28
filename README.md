# Navigation Rail Plus

A highly customizable, responsive navigation system for Flutter that supports both **Navigation Rail
** and **Drawer** modes with smooth animations and flexible configuration.

---

## ✨ Features

* Fully customizable navigation rail
* Built-in **responsive layout** (Rail ↔ Drawer)
* Expandable / collapsible rail
* Fixed + scrollable navigation items
* Header, footer, and trailing sections
* Hover, selected, and disabled states
* Smooth animations
* GetX-powered state management
* Clean and scalable architecture

---

## Demo

#Navigation rail
</br>
</br>
<img src="https://github.com/fateme-shm/navigation_rail_plus/blob/main/expand_navigation_rail.png" width="500" alt="Navigation rail expand" />
</br>
<img src="https://github.com/fateme-shm/navigation_rail_plus/blob/main/collapsed_navigation_rail.png" width="500" alt="Navigation rail collapsed" />
</br>
#Navigation Drawer
</br>
</br>
<img src="https://github.com/fateme-shm/navigation_rail_plus/blob/main/navigation_drawer.png" width="300" alt="Navigation drawer" />

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  navigation_rail_plus: ^latest_version
```

---

## 🚀 Quick Start

```
NavigationRailPlus(
  selectedIndex: 0,
  responsiveBody: YourMainScreen(),
  navigationLeadingConfig: NavigationLeadingConfig(
    fixLeadingItems: [
      NavigationRailPlusDestination(
        icon: Icons.home,
        label: 'Home',
      ),
      NavigationRailPlusDestination(
        icon: Icons.settings,
        label: 'Settings',
      ),
    ],
  ),
  onDestinationSelected: (index) {
    print('Selected: $index');
  },
)
```

---

## 🧠 Architecture Overview

The system is built using multiple configuration classes:

| Config                          | Responsibility                     |
|---------------------------------|------------------------------------|
| `NavigationGlobalConfig`        | Layout behavior, animation, sizing |
| `NavigationHeaderConfig`        | Top header UI                      |
| `NavigationLeadingConfig`       | Navigation items                   |
| `NavigationFooterConfig`        | Bottom section                     |
| `NavigationRailPlusDestination` | Individual item                    |

---

## 📐 Responsive Behavior

By default:

* **Mobile → Drawer**
* **Tablet/Desktop → Navigation Rail**

Controlled via:

```
NavigationGlobalConfig(
  responsiveLayout: true,
)
```

---

## ⚙️ Configuration

### 1. Global Configuration

```
NavigationGlobalConfig(
  responsiveLayout: true,
  mode: NavigationRailMode.rail,
  collapsedRailWidth: 60,
  expandedRailWidth: 260,
  drawerWidth: 300,
  animationDuration: Duration(milliseconds: 300),
  backgroundColor: Colors.white,
  needFixedSize: false,
  closeOnSelectDrawerItem: true,
)
```

---

### 2. Header Configuration

```
NavigationHeaderConfig(
  header: Text("My App"),
  headerIcon: Icon(Icons.menu),
  headerIconSize: 24,
  headerIconColor: Colors.black,
  toggleNavigationIcon: Icon(Icons.menu_open),
)
```

---

### 3. Leading (Navigation Items)

```
NavigationLeadingConfig(
  fixLeadingItems: [
    NavigationRailPlusDestination(
      icon: Icons.dashboard,
      label: "Dashboard",
    ),
  ],
  scrollableLeadingItems: [
    NavigationRailPlusDestination(
      icon: Icons.person,
      label: "Profile",
    ),
  ],
  leadingColor: Colors.grey,
  selectedLeadingColor: Colors.blue,
  leadingHoverColor: Colors.blue.withOpacity(0.1),
  leadingIconSize: 22,
  needTooltip: true,
)
```

---

### 4. Footer Configuration

```
NavigationFooterConfig(
  trailing: Icon(Icons.notifications),
  footer: Text("v1.0.0"),

  collapsedTrailing: Icon(Icons.notifications_none),
  collapsedFooter: Text("v1"),
)
```

---

### 5. Destination Item

```
NavigationRailPlusDestination(
  icon: Icons.home,
  selectedIcon: Icons.home_filled,
  label: "Home",
  disabled: false,
)
```

---

## 🎯 Full Example

```
NavigationRailPlus(
  selectedIndex: 1,

  navigationGlobalConfig: NavigationGlobalConfig(
    expandedRailWidth: 260,
    collapsedRailWidth: 70,
  ),

  navigationHeaderConfig: NavigationHeaderConfig(
    header: Text("My App"),
  ),

  navigationLeadingConfig: NavigationLeadingConfig(
    fixLeadingItems: [
      NavigationRailPlusDestination(
        icon: Icons.home,
        label: "Home",
      ),
      NavigationRailPlusDestination(
        icon: Icons.settings,
        label: "Settings",
      ),
    ],
  ),

  navigationFooterConfig: NavigationFooterConfig(
    footer: Text("Footer"),
  ),

  responsiveBody: Center(
    child: Text("Main Content"),
  ),

  onDestinationSelected: (index) {
    // Handle navigation
  },
)
```

---

## 🎨 Behavior Details

### Expand / Collapse

* Controlled internally via `NavigationController`
* Toggle button in header
* Animated width transition

---

### Hover State

* Applies `leadingHoverColor`
* Disabled items ignore hover

---

### Selected State

* Uses `selectedLeadingColor`
* Supports `selectedIcon`

---

### Disabled Items

```
NavigationRailPlusDestination(
  icon: Icons.lock,
  label: 'Locked',
  disabled: true,
)
```

* Reduced opacity
* No interaction

---

## 📱 Drawer Mode

Force drawer manually:

```
NavigationGlobalConfig(
  responsiveLayout: false,
  mode: NavigationRailMode.drawer,
)
```

---

## 🧩 Advanced Usage

### Add Custom Content Between Items

```
navigationMainContent: [
  SizedBox(height: 20),
  Text("Extra Section"),
]
```

---

### Close Drawer on Selection

```
NavigationGlobalConfig(
  closeOnSelectDrawerItem: true,
)
```

---

# 📘 API Reference

## `NavigationRailPlus`

| Property                  | Type                      | Default      | Description                                                  |
|---------------------------|---------------------------|--------------|--------------------------------------------------------------|
| `navigationLeadingConfig` | `NavigationLeadingConfig` | **required** | Defines all navigation items and their styling               |
| `selectedIndex`           | `int?`                    | `0`          | Currently selected navigation index                          |
| `responsiveBody`          | `Widget?`                 | `null`       | Main content shown beside rail or inside scaffold            |
| `navigationHeaderConfig`  | `NavigationHeaderConfig?` | `null`       | Top header configuration                                     |
| `navigationFooterConfig`  | `NavigationFooterConfig?` | `null`       | Bottom footer & trailing configuration                       |
| `navigationGlobalConfig`  | `NavigationGlobalConfig?` | `null`       | Controls layout behavior and global styles                   |
| `navigationMainContent`   | `List<Widget>?`           | `null`       | Extra widgets shown between items and footer (expanded only) |
| `onDestinationSelected`   | `ValueChanged<int>?`      | `null`       | Callback when a navigation item is selected                  |

---

## `NavigationGlobalConfig`

| Property                  | Type                 | Default            | Description                                 |
|---------------------------|----------------------|--------------------|---------------------------------------------|
| `responsiveLayout`        | `bool`               | `true`             | Enables auto switch between rail and drawer |
| `mode`                    | `NavigationRailMode` | `rail`             | Forces layout mode (`rail` or `drawer`)     |
| `animationDuration`       | `Duration?`          | `250ms` (fallback) | Animation duration for expand/collapse      |
| `drawerWidth`             | `double?`            | `null`             | Width of drawer in drawer mode              |
| `collapsedRailWidth`      | `double`             | `50`               | Width when rail is collapsed                |
| `expandedRailWidth`       | `double`             | `250`              | Width when rail is expanded                 |
| `needFixedSize`           | `bool`               | `false`            | Disables dynamic resizing if true           |
| `closeOnSelectDrawerItem` | `bool`               | `true`             | Auto closes drawer on item click            |
| `backgroundColor`         | `Color?`             | `null`             | Background color of navigation container    |

---

## `NavigationHeaderConfig`

| Property               | Type      | Default | Description                          |
|------------------------|-----------|---------|--------------------------------------|
| `header`               | `Widget?` | `null`  | Custom header widget (expanded mode) |
| `headerIcon`           | `Widget?` | `null`  | Icon used in collapsed mode          |
| `headerIconSize`       | `double?` | `null`  | Size of header icon                  |
| `headerIconColor`      | `Color?`  | `null`  | Color of header icon                 |
| `toggleNavigationIcon` | `Icon?`   | `null`  | Custom expand/collapse toggle icon   |

---

## `NavigationLeadingConfig`

| Property                 | Type                                   | Default          | Description                              |
|--------------------------|----------------------------------------|------------------|------------------------------------------|
| `fixLeadingItems`        | `List<NavigationRailPlusDestination>`  | **required**     | Always visible (non-scrollable) items    |
| `scrollableLeadingItems` | `List<NavigationRailPlusDestination>?` | `null`           | Scrollable navigation items              |
| `leadingColor`           | `Color?`                               | Theme-based      | Default icon & text color                |
| `selectedLeadingColor`   | `Color?`                               | Theme-based      | Color when item is selected              |
| `leadingHoverColor`      | `Color?`                               | Theme-based      | Background color on hover                |
| `leadingIconSize`        | `double?`                              | Theme-based      | Icon size                                |
| `leadingIconPadding`     | `EdgeInsets?`                          | Internal default | Padding around each item                 |
| `needTooltip`            | `bool`                                 | `true`           | Shows tooltip (useful in collapsed mode) |

---

## `NavigationFooterConfig`

| Property            | Type      | Default | Description                      |
|---------------------|-----------|---------|----------------------------------|
| `footer`            | `Widget?` | `null`  | Bottom widget in expanded state  |
| `collapsedFooter`   | `Widget?` | `null`  | Bottom widget in collapsed state |
| `trailing`          | `Widget?` | `null`  | Widget above footer (expanded)   |
| `collapsedTrailing` | `Widget?` | `null`  | Widget above footer (collapsed)  |

---

## `NavigationRailPlusDestination`

| Property       | Type        | Default      | Description                  |
|----------------|-------------|--------------|------------------------------|
| `icon`         | `IconData`  | **required** | Default icon                 |
| `selectedIcon` | `IconData?` | `null`       | Icon when selected           |
| `label`        | `String`    | **required** | Text label                   |
| `disabled`     | `bool`      | `false`      | Disables interaction if true |

---

# 🧩 Enum

## `NavigationRailMode`

| Value    | Description                        |
|----------|------------------------------------|
| `rail`   | Displays navigation as a side rail |
| `drawer` | Displays navigation as a drawer    |

---

You’ve already documented the navigation layer well — what’s missing is a **clear, structured
reference for your scaffold system**, which is actually one of the strongest parts of your package.

Below is a **clean, production-ready README table section** for your `CustomScaffold`.

---

# 📦 `CustomScaffold` API Reference

A flexible wrapper around `Scaffold` with built-in support for:

* AppBar customization
* Bottom sheet handling
* Loading / error / empty states
* Pull-to-refresh
* SafeArea control
* Overlay styling
* Drawer integration

---

## 🧱 Core Scaffold

| Property                    | Type                        | Default | Description                                           |
|-----------------------------|-----------------------------|---------|-------------------------------------------------------|
| `scaffoldKey`               | `GlobalKey<ScaffoldState>?` | `null`  | Controls scaffold (e.g. open drawer programmatically) |
| `backgroundColor`           | `Color?`                    | Theme   | Scaffold background color                             |
| `underneathBackgroundColor` | `Color?`                    | Auto    | Background behind scaffold (used with bottom sheet)   |
| `padding`                   | `EdgeInsetsGeometry?`       | `0`     | Padding for body                                      |
| `bottomNavigationBar`       | `Widget?`                   | `null`  | Bottom navigation bar                                 |
| `drawer`                    | `Widget?`                   | `null`  | Drawer widget                                         |
| `resizeToAvoidBottomInset`  | `bool`                      | `true`  | Adjust layout when keyboard appears                   |

---

## 📱 AppBar Configuration

| Property                          | Type                   | Default | Description                     |
|-----------------------------------|------------------------|---------|---------------------------------|
| `needNoAppBar`                    | `bool`                 | `false` | Removes AppBar entirely         |
| `appBar`                          | `PreferredSizeWidget?` | `null`  | Fully custom AppBar             |
| `appBarText`                      | `String?`              | `null`  | Title text                      |
| `appBarTextStyle`                 | `TextStyle?`           | Theme   | Title text style                |
| `appBarCenterTitle`               | `bool`                 | `false` | Centers title                   |
| `appBarActions`                   | `List<Widget>?`        | `null`  | Right-side actions              |
| `appBarBackButton`                | `Widget?`              | Default | Custom back button              |
| `appBarBackButtonTap`             | `VoidCallback?`        | Pop     | Back button callback            |
| `appBarBackButtonColor`           | `Color?`               | Theme   | Back button color               |
| `appBarTitleSpacing`              | `double?`              | Default | Spacing before title            |
| `appBarBackgroundColor`           | `Color?`               | Theme   | AppBar background               |
| `appBarForceMaterialTransparency` | `bool?`                | `true`  | Enables Material 3 transparency |
| `extendBodyBehindAppBar`          | `bool`                 | `false` | Allows body behind AppBar       |
| `needOverlayStyle`                | `bool`                 | `true`  | Applies system status bar style |

---

## 🔄 AppBar Bottom State (Loading / Divider)

| Property                | Type      | Default | Description                          |
|-------------------------|-----------|---------|--------------------------------------|
| `appBarBottomLoading`   | `bool?`   | `false` | Shows loading indicator below AppBar |
| `appBarBottomDivider`   | `bool?`   | `false` | Shows divider under AppBar           |
| `appBarBottomRxLoading` | `RxBool?` | `null`  | Reactive loading state (GetX)        |

---

## 📊 Content State Handling

| Property                 | Type                             | Default | Description                  |
|--------------------------|----------------------------------|---------|------------------------------|
| `bodyBuilder`            | `Widget Function(BuildContext)?` | `null`  | Main content builder         |
| `loadingBuilder`         | `Widget Function(BuildContext)?` | Default | Custom loading widget        |
| `errorBuilder`           | `Widget Function(BuildContext)?` | Empty   | Custom error widget          |
| `noContentToShowBuilder` | `Widget Function(BuildContext)?` | Empty   | Empty state widget           |
| `isContentLoading`       | `bool?`                          | `false` | Shows loading state          |
| `isContentFailed`        | `bool?`                          | `false` | Shows error state            |
| `isNoContentToShow`      | `bool?`                          | `false` | Shows empty state            |
| `bodyMaxWidth`           | `double?`                        | `null`  | Constrains max width of body |

---

## 🔄 Pull-To-Refresh

| Property    | Type        | Default | Description                      |
|-------------|-------------|---------|----------------------------------|
| `onRefresh` | `Function?` | `null`  | Enables pull-to-refresh behavior |

---

## 📥 Bottom Sheet

| Property                     | Type                             | Default | Description                 |
|------------------------------|----------------------------------|---------|-----------------------------|
| `bottomSheet`                | `Widget?`                        | `null`  | Bottom sheet content        |
| `bottomSheetLoadingBuilder`  | `Widget Function(BuildContext)?` | `null`  | Bottom sheet during loading |
| `bottomSheetBackgroundColor` | `Color?`                         | Theme   | Background color            |
| `bottomSheetPaddingBottom`   | `double?`                        | `null`  | Bottom padding              |
| `bottomSheetNeedFullWidth`   | `bool`                           | `true`  | Stretch to full width       |
| `bottomSheetMaxWidth`        | `double?`                        | `null`  | Max width constraint        |

---

## 🎯 Floating Action Button

| Property                       | Type                            | Default | Description     |
|--------------------------------|---------------------------------|---------|-----------------|
| `floatingActionButton`         | `Widget?`                       | `null`  | Floating button |
| `floatingActionButtonLocation` | `FloatingActionButtonLocation?` | Default | FAB position    |

---

## 🛡️ SafeArea Control

| Property           | Type   | Default | Description                |
|--------------------|--------|---------|----------------------------|
| `isSafeAreaTop`    | `bool` | `false` | Applies SafeArea at top    |
| `isSafeAreaBottom` | `bool` | `true`  | Applies SafeArea at bottom |

---

## 🔙 Navigation / Pop Control

| Property                 | Type                       | Default | Description                    |
|--------------------------|----------------------------|---------|--------------------------------|
| `canPop`                 | `bool`                     | `true`  | Allows back navigation         |
| `onPopInvokedWithResult` | `Function(bool, Object?)?` | `null`  | Callback when pop is triggered |

---

# 🧠 Key Notes

* `bodyBuilder` is **required** for meaningful UI
* State priority:

  ```
  Loading → Error → Empty → Content
  ```
* `onRefresh` only works if scrollable widget exists
* `bottomSheet` adapts automatically based on loading/error state
* `underneathBackgroundColor` ensures seamless UI behind bottom sheet

---

# ✅ Example Usage

```
CustomScaffold(
  appBarText: 'Dashboard',
  appBarBottomRxLoading: controller.isLoading,
  onRefresh: controller.fetchData,
  isContentLoading: controller.isLoading.value,
  bodyBuilder: (context) {
    return ListView(
      children: [
        Text('Content'),
      ],
    );
  },
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
)
```

---

# 🔥 Final Note

This `CustomScaffold` is not just a wrapper — it's effectively a **UI state orchestration layer**.

If you want to take it to the next level, consider:

* Extracting **state config into a separate class**
* Supporting **streams (not only RxBool)**
* Reducing boolean flags with a single `enum ViewState { loading, error, empty, data }`

# 🧠 Notes for Developers

* If both `responsiveLayout = true` and `mode` are provided → **responsive takes priority**
* `selectedIndex` must always match your destination list length
* `scrollableLeadingItems` should be used for long menus to avoid overflow
* Use `collapsedFooter` and `collapsedTrailing` to maintain UX consistency in compact mode

---

## 🤝 Contribution

Contributions are welcome. Open an issue or submit a PR.

---

## 📄 License

MIT License

