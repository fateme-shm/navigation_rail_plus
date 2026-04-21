import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation_rail_plus/model/navigation_footer_config.dart';
import 'package:navigation_rail_plus/model/navigation_global_config.dart';
import 'package:navigation_rail_plus/model/navigation_header_config.dart';
import 'package:navigation_rail_plus/model/navigation_leading_config.dart';

import 'package:navigation_rail_plus/res/global_config.dart';
import 'package:navigation_rail_plus/res/context_extension.dart';
import 'package:navigation_rail_plus/res/utils/screen_utils.dart';
import 'package:navigation_rail_plus/enums/navigation_rail_mode.dart';
import 'package:navigation_rail_plus/controller/navigation_rail_controller.dart';
import 'package:navigation_rail_plus/model/custom_navigation_rail_destination.dart';

class CustomNavigationRail extends StatefulWidget {
  /// Navigatio header config
  final NavigationHeaderConfig? navigationHeaderConfig;

  /// Navigation leading config
  final NavigationLeadingConfig navigationLeadingConfig;

  // Navigation footer config
  final NavigationFooterConfig? navigationFooterConfig;

  // Navigation globar config
  final NavigationGlobalConfig? navigationGlobalConfig;

  /// Additional widgets rendered between navigation items and footer.
  /// Only visible in expanded state.
  final List<Widget>? navigationMainContent;

  /// Main content widget used in responsive layouts.
  /// Displayed alongside rail or inside scaffold body.
  final Widget? responsiveBody;

  /// Index of the currently selected navigation destination.
  final int? selectedIndex;

  /// Callback triggered when a navigation item is selected.
  /// Returns the selected index.
  final ValueChanged<int>? onDestinationSelected;

  const CustomNavigationRail({
    super.key,
    required this.navigationLeadingConfig,

    this.selectedIndex = 0,

    this.responsiveBody,
    this.navigationHeaderConfig,
    this.navigationGlobalConfig,
    this.navigationMainContent,
    this.navigationFooterConfig,
    this.onDestinationSelected,
  });

  @override
  State<CustomNavigationRail> createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends State<CustomNavigationRail> {
  /// Index of the item currently hovered by mouse (used for hover UI state)
  int? hoveredIndex;

  /// Controls visibility of divider based on scroll position
  bool showDivider = false;

  /// Fallback animation duration when not provided via config
  Duration animationDuration = Duration(milliseconds: 250);

  /// Navigation controller responsible for:
  /// - expansion/collapse state
  /// - scroll controller
  /// - shared global configuration
  NavigationController controller = Get.put(
    NavigationController(),
    tag: GlobalConfig().navRailControllerKey,
  );

  /// Returns combined list of all navigation destinations
  /// (fixed + scrollable)
  List<CustomNavigationRailDestination> get _allDestinations {
    return [
      ...widget.navigationLeadingConfig.fixLeadingItems,
      ...?widget.navigationLeadingConfig.scrollableLeadingItems,
    ];
  }

  @override
  void initState() {
    super.initState();

    /// Listen to scroll offset to determine divider visibility
    controller.scrollController.addListener(() {
      bool shouldShow =
          controller.scrollController.hasClients &&
          controller.scrollController.offset > 4;

      /// Update state only when value changes to avoid unnecessary rebuilds
      if (shouldShow != showDivider) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() => showDivider = shouldShow);
        });
      }
    });
  }

  @override
  void dispose() {
    /// Dispose controller resources (scroll, etc.)
    controller.disposeVariable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Handle responsive layout automatically
    if (widget.navigationGlobalConfig?.responsiveLayout ?? true) {
      bool isMobile = context.screenType == DeviceScreenType.mobile;

      return isMobile ? _responsiveDrawerWrapper : _responsiveRailWrapper;
    }

    /// Manual mode handling
    switch (widget.navigationGlobalConfig?.mode) {
      case null:
      case NavigationRailMode.rail:
        return _railBodyContent;
      case NavigationRailMode.drawer:
        return _drawerBodyContent;
    }
  }

  /// Layout for tablet/desktop → rail + content
  Widget get _responsiveRailWrapper {
    return Row(
      children: [
        _railBodyContent,
        const VerticalDivider(thickness: 1, width: 0),

        /// Main content area
        Expanded(child: widget.responsiveBody ?? const SizedBox.shrink()),
      ],
    );
  }

  /// Layout for mobile → drawer-based navigation
  Widget get _responsiveDrawerWrapper {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            /// Opens navigation drawer
            leading: IconButton(
              icon: Icon(CupertinoIcons.line_horizontal_3),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          drawer: _drawerBodyContent,
          body: widget.responsiveBody ?? const SizedBox.shrink(),
        );
      },
    );
  }

  /// Main navigation rail UI (expandable/collapsible)
  Widget get _railBodyContent {
    return Obx(() {
      return AnimatedSize(
        curve: Curves.easeInOut,
        duration:
            widget.navigationGlobalConfig?.animationDuration ??
            animationDuration,
        alignment: Alignment.topCenter,
        child: Container(
          /// Width changes based on expansion state
          width: controller.isNavExpanded.value
              ? widget.navigationGlobalConfig?.expandedRailWidth
              : widget.navigationGlobalConfig?.collapsedRailWidth,
          color: widget.navigationGlobalConfig?.backgroundColor,
          child: Column(
            crossAxisAlignment: .center,
            children: [
              const SizedBox(height: 8),

              /// Header section
              if (widget.navigationHeaderConfig != null) ...[
                _railHeaderContent,
              ],

              /// Fix leading section
              const SizedBox(height: 8),
              _fixedLeadingItemContent,

              /// Divider key
              if (widget.navigationLeadingConfig.scrollableLeadingItems !=
                      null &&
                  controller.isNavExpanded.value) ...[
                _fixedDividerContent,
              ],

              /// Body section
              Expanded(child: _scrollableContent),

              /// Trailing section
              if (widget.navigationFooterConfig?.trailing != null &&
                  controller.isNavExpanded.value) ...[
                widget.navigationFooterConfig?.trailing ??
                    const SizedBox.shrink(),
                const SizedBox(height: 8),
              ],

              /// Trailing section
              if (widget.navigationFooterConfig?.collapsedTrailing != null &&
                  !controller.isNavExpanded.value) ...[
                widget.navigationFooterConfig?.collapsedTrailing ??
                    const SizedBox.shrink(),
                SizedBox(height: 16),
              ],

              /// Footer (expanded)
              if (widget.navigationFooterConfig?.footer != null &&
                  controller.isNavExpanded.value) ...[
                widget.navigationFooterConfig?.footer ??
                    const SizedBox.shrink(),
                const SizedBox(height: 16),
              ],

              /// Footer (collapsed)
              if (widget.navigationFooterConfig?.collapsedFooter != null &&
                  !controller.isNavExpanded.value) ...[
                widget.navigationFooterConfig?.collapsedFooter ??
                    const SizedBox.shrink(),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      );
    });
  }

  /// Drawer-based navigation UI
  Widget get _drawerBodyContent {
    return Drawer(
      width: widget.navigationGlobalConfig?.drawerWidth,
      backgroundColor: widget.navigationGlobalConfig?.backgroundColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),

            /// Header section
            if (widget.navigationHeaderConfig != null) ...[
              const SizedBox(width: 14),
              widget.navigationHeaderConfig?.header ?? const SizedBox.shrink(),
            ],

            /// Fix leading section
            const SizedBox(height: 8),
            _fixedLeadingItemContent,

            /// Divider key
            if (widget.navigationLeadingConfig.scrollableLeadingItems != null &&
                controller.isNavExpanded.value) ...[
              _fixedDividerContent,
            ],

            /// Body section
            Expanded(child: _scrollableContent),

            if (widget.navigationFooterConfig?.trailing != null) ...[
              widget.navigationFooterConfig?.trailing ??
                  const SizedBox.shrink(),
              const SizedBox(height: 8),
            ],

            /// Footer section
            if (widget.navigationFooterConfig?.footer != null) ...[
              widget.navigationFooterConfig?.footer ?? const SizedBox.shrink(),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }

  Widget get _railHeaderContent {
    return Column(
      children: [
        if (controller.isNavExpanded.value) ...[
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .center,
            children: [
              const SizedBox(width: 14),
              if (widget.navigationHeaderConfig?.header != null)
                Expanded(
                  child:
                      widget.navigationHeaderConfig?.header ??
                      const SizedBox.shrink(),
                ),
              if (!(widget.navigationGlobalConfig?.needFixedSize ?? false)) ...[
                Row(
                  children: [
                    IconButton(
                      onPressed: controller.toggleNavigationRail,
                      visualDensity: VisualDensity.compact,
                      icon:
                          widget.navigationHeaderConfig?.toggleNavigationIcon ??
                          Icon(
                            size: context.mediumIcon,
                            CupertinoIcons.sidebar_right,
                            color: context.appColorScheme.shadow,
                          ),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ],
            ],
          ),
        ] else ...[
          IconButton(
            onPressed: controller.toggleNavigationRail,
            icon:
                widget.navigationHeaderConfig?.headerIcon ??
                Icon(
                  Icons.menu,
                  color:
                      widget.navigationHeaderConfig?.headerIconColor ??
                      context.appColorScheme.onSurface,
                  size:
                      widget.navigationHeaderConfig?.headerIconSize ??
                      context.largeIcon,
                ),
          ),
        ],
      ],
    );
  }

  // Fixed leading item
  Widget get _fixedLeadingItemContent {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.navigationLeadingConfig.fixLeadingItems.length,
      itemBuilder: (context, index) => _destinationItemContent(index),
    );
  }

  // Scroll leading items + body content of navigation
  Widget get _scrollableContent {
    List<CustomNavigationRailDestination> scrollableItems =
        widget.navigationLeadingConfig.scrollableLeadingItems ?? [];

    return ListView(
      padding: EdgeInsets.zero,
      controller: controller.scrollController,
      children: [
        for (int i = 0; i < scrollableItems.length; i++) ...[
          _destinationItemContent(
            widget.navigationLeadingConfig.fixLeadingItems.length + i,
          ),
        ],

        if (widget.navigationMainContent != null &&
            controller.isNavExpanded.value) ...[
          Opacity(opacity: showDivider ? 0 : 1, child: _dividerContent),
          const SizedBox(height: 12),
          ...widget.navigationMainContent!,
        ],
      ],
    );
  }

  Widget get _fixedDividerContent {
    return AnimatedSwitcher(
      duration:
          widget.navigationGlobalConfig?.animationDuration ?? animationDuration,
      child: showDivider ? _dividerContent : const SizedBox.shrink(),
    );
  }

  Widget get _dividerContent {
    return Divider(
      height: 0,
      thickness: 0.5,
      color: context.appColorScheme.outlineVariant,
    );
  }

  /// Builds a single navigation item (icon + optional label)
  Widget _destinationItemContent(int index) {
    CustomNavigationRailDestination item = _allDestinations[index];

    int selectedIndex = widget.selectedIndex ?? 0;

    /// UI states
    bool isHovered = hoveredIndex == index;
    bool isSelected = index == selectedIndex && index < _allDestinations.length;

    /// Determines whether label should be visible
    bool needToShowLabel =
        widget.navigationGlobalConfig?.mode == NavigationRailMode.drawer ||
        controller.isNavExpanded.value;

    /// Colors
    Color leadingColor =
        widget.navigationLeadingConfig.leadingColor ??
        context.appColorScheme.shadow;
    Color selectedLeadingColor =
        widget.navigationLeadingConfig.selectedLeadingColor ??
        context.appColorScheme.shadow;

    /// Determines if drawer should close after selection
    bool canPop =
        widget.navigationGlobalConfig?.mode == NavigationRailMode.drawer &&
        (widget.navigationGlobalConfig?.closeOnSelectDrawerItem ?? true) &&
        Navigator.of(context).canPop();

    return MouseRegion(
      onEnter: (_) {
        if (item.disabled) return;
        setState(() => hoveredIndex = index);
      },
      onExit: (_) {
        if (item.disabled) return;
        setState(() => hoveredIndex = null);
      },
      child: AnimatedContainer(
        curve: Curves.easeOut,
        duration:
            widget.navigationGlobalConfig?.animationDuration ??
            animationDuration,

        /// Hover & selected background styling
        decoration: BoxDecoration(
          borderRadius: controller.globalConfig.globalBorderRadius * 2,
          color: isHovered || (isSelected && index != 0)
              ? (widget.navigationLeadingConfig.leadingHoverColor ??
                    context.appColorScheme.outlineVariant.withValues(
                      alpha: 0.2,
                    ))
              : null,
        ),
        margin: controller.globalConfig.globalMargin,
        child: InkWell(
          onTap: item.disabled
              ? null
              : () {
                  /// Notify parent
                  widget.onDestinationSelected?.call(index);

                  /// Close drawer if required
                  if (canPop) Navigator.of(context).pop();
                },
          child: Opacity(
            opacity: item.disabled ? 0.5 : 1,
            child: Padding(
              padding:
                  widget.navigationLeadingConfig.leadingIconPadding ??
                  EdgeInsets.symmetric(
                    horizontal:
                        controller.globalConfig.symmetricMargin.horizontal,
                    vertical:
                        controller.globalConfig.symmetricMargin.vertical * 3,
                  ),
              child: Tooltip(
                message: widget.navigationLeadingConfig.needTooltip
                    ? item.label
                    : '',
                child: Row(
                  mainAxisAlignment: needToShowLabel ? .start : .center,
                  crossAxisAlignment: .center,
                  children: [
                    Flexible(
                      child: Icon(
                        isSelected && item.selectedIcon != null
                            ? item.selectedIcon
                            : item.icon,
                        size:
                            widget.navigationLeadingConfig.leadingIconSize ??
                            context.mediumIcon,
                        color: isSelected ? selectedLeadingColor : leadingColor,
                      ),
                    ),
                    if (needToShowLabel) ...[
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          item.label,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.appTextTheme.labelLarge?.copyWith(
                            color: isSelected
                                ? selectedLeadingColor
                                : leadingColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
