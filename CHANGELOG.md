# Changelog

All notable changes to this project will be documented in this file.

The format follows **Keep a Changelog** and adheres to **Semantic Versioning**.

---

## [1.0.0] - Initial Release

### ✨ Added

* Initial release of `navigation_rail_plus`
* Fully customizable `NavigationRail` widget
* Support for both **Navigation Rail** and **Drawer** modes
* Automatic responsive layout (Rail ↔ Drawer)

### 🧱 Core Features

* Expandable and collapsible navigation rail
* Smooth animated transitions using `AnimatedSize` and `AnimatedContainer`
* Fixed and scrollable navigation item sections
* Hover, selected, and disabled states for navigation items
* Tooltip support for collapsed rail

### ⚙️ Configuration System

* `NavigationGlobalConfig`

    * Responsive layout control
    * Rail and drawer mode switching
    * Custom widths (collapsed / expanded / drawer)
    * Animation duration configuration
    * Background color support
    * Optional fixed sizing behavior
    * Auto-close drawer on item selection

* `NavigationHeaderConfig`

    * Custom header widget support
    * Collapsed mode icon fallback
    * Toggle navigation icon customization

* `NavigationLeadingConfig`

    * Fixed and scrollable navigation items
    * Icon size and padding customization
    * Hover and selected color states
    * Tooltip enable/disable option

* `NavigationFooterConfig`

    * Footer for expanded and collapsed states
    * Trailing widgets above footer
    * Independent collapsed/expanded configurations

### 🧩 Components

* `NavigationRailPlusDestination`

    * Icon and optional selected icon
    * Label support
    * Disabled state handling

### 📱 Responsive Behavior

* Mobile → Drawer layout
* Tablet/Desktop → Navigation Rail layout

## [1.0.1]

* Fix reported bug
* Change navigation rail class name


## [1.0.2]

* Fix reported bug
* Add custom scaffold data to navigation