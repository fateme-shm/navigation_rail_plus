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
CustomNavigationRail(
  selectedIndex: 0,
  responsiveBody: YourMainScreen(),
  navigationLeadingConfig: NavigationLeadingConfig(
    fixLeadingItems: [
      CustomNavigationRailDestination(
        icon: Icons.home,
        label: 'Home',
      ),
      CustomNavigationRailDestination(
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

| Config                            | Responsibility                     |
|-----------------------------------|------------------------------------|
| `NavigationGlobalConfig`          | Layout behavior, animation, sizing |
| `NavigationHeaderConfig`          | Top header UI                      |
| `NavigationLeadingConfig`         | Navigation items                   |
| `NavigationFooterConfig`          | Bottom section                     |
| `CustomNavigationRailDestination` | Individual item                    |

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
    CustomNavigationRailDestination(
      icon: Icons.dashboard,
      label: "Dashboard",
    ),
  ],
  scrollableLeadingItems: [
    CustomNavigationRailDestination(
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
CustomNavigationRailDestination(
  icon: Icons.home,
  selectedIcon: Icons.home_filled,
  label: "Home",
  disabled: false,
)
```

---

## 🎯 Full Example

```
CustomNavigationRail(
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
      CustomNavigationRailDestination(
        icon: Icons.home,
        label: "Home",
      ),
      CustomNavigationRailDestination(
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
CustomNavigationRailDestination(
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

Below is a structured, production-quality **API reference table** covering all public variables
across your configuration classes and main widget.

---

# 📘 API Reference

## `CustomNavigationRail`

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

| Property                 | Type                                     | Default          | Description                              |
|--------------------------|------------------------------------------|------------------|------------------------------------------|
| `fixLeadingItems`        | `List<CustomNavigationRailDestination>`  | **required**     | Always visible (non-scrollable) items    |
| `scrollableLeadingItems` | `List<CustomNavigationRailDestination>?` | `null`           | Scrollable navigation items              |
| `leadingColor`           | `Color?`                                 | Theme-based      | Default icon & text color                |
| `selectedLeadingColor`   | `Color?`                                 | Theme-based      | Color when item is selected              |
| `leadingHoverColor`      | `Color?`                                 | Theme-based      | Background color on hover                |
| `leadingIconSize`        | `double?`                                | Theme-based      | Icon size                                |
| `leadingIconPadding`     | `EdgeInsets?`                            | Internal default | Padding around each item                 |
| `needTooltip`            | `bool`                                   | `true`           | Shows tooltip (useful in collapsed mode) |

---

## `NavigationFooterConfig`

| Property            | Type      | Default | Description                      |
|---------------------|-----------|---------|----------------------------------|
| `footer`            | `Widget?` | `null`  | Bottom widget in expanded state  |
| `collapsedFooter`   | `Widget?` | `null`  | Bottom widget in collapsed state |
| `trailing`          | `Widget?` | `null`  | Widget above footer (expanded)   |
| `collapsedTrailing` | `Widget?` | `null`  | Widget above footer (collapsed)  |

---

## `CustomNavigationRailDestination`

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

