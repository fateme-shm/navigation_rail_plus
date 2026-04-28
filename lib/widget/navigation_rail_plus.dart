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
import 'package:navigation_rail_plus/controller/navigation_controller.dart';
import 'package:navigation_rail_plus/model/navigation_rail_plus_destination.dart';
import 'package:navigation_rail_plus/widget/scaffold/bottom_app_bar_section.dart';
import 'package:navigation_rail_plus/widget/scaffold/custom_scaffold.dart';

class NavigationRailPlus extends StatefulWidget {
  // External globalKey
  final GlobalKey<ScaffoldState>? externalScaffoldKey;

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

  ///----------------------------------------------------
  /// Scaffold data/variable section
  ///----------------------------------------------------

  /// AppBar related properties

  /// Whether to center the title
  final bool appBarCenterTitle;

  /// Show a loading indicator at AppBar bottom
  final bool? appBarBottomLoading;

  /// Show divider under AppBar
  final bool? appBarBottomDivider;

  /// Allow content behind AppBar (e.g. transparent AppBar)
  final bool extendBodyBehindAppBar;

  /// Reactive loading indicator for AppBar bottom
  final RxBool? appBarBottomRxLoading;

  /// Title text
  final String? appBarText;

  /// Custom back button widget
  final Widget? appBarBackButton;

  /// Title style
  final TextStyle? appBarTextStyle;

  /// Fully custom AppBar
  final PreferredSizeWidget? appBar;

  /// Right-side action buttons
  final List<Widget>? appBarActions;

  /// Color for back button icon
  final Color? appBarBackButtonColor;

  /// Back button callback
  final VoidCallback? appBarBackButtonTap;

  /// Note: To use [appBarBackgroundColor], set [appBarForceMaterialTransparency] = false
  final Color? appBarBackgroundColor;

  /// Space between title appbar and back button
  final double? appBarTitleSpacing;

  /// Force Material 3 transparency behavior
  final bool? appBarForceMaterialTransparency;

  /// Whether to apply system overlay style (status bar)
  final bool needOverlayStyle;

  /// BottomSheet related properties

  /// Custom bottom sheet widget
  final Widget? bottomSheet;

  /// If you need width of screen bottom sheet;
  final bool bottomSheetNeedFullWidth;
  final double? bottomSheetMaxWidth;
  final double? appBarMaxWidth;

  /// Padding for bottom sheet
  final double? bottomSheetPaddingBottom;

  /// Bottom sheet background color
  final Color? bottomSheetBackgroundColor;

  /// Bottom sheet loader
  final Widget Function(BuildContext context)? bottomSheetLoadingBuilder;

  /// Builders for handling dynamic UI states

  /// Main content
  final Widget Function(BuildContext context)? bodyBuilder;
  final double? bodyMaxWidth;

  /// Error content
  final Widget Function(BuildContext context)? errorBuilder;

  /// Loading content
  final Widget Function(BuildContext context)? loadingBuilder;

  /// Empty content
  final Widget Function(BuildContext context)? noContentToShowBuilder;

  /// Flag for error state
  final bool? isContentFailed;

  /// Flag for loading state
  final bool? isContentLoading;

  /// Flag for empty state
  final bool? isNoContentToShow;

  /// Scaffold background
  final Color? backgroundColor;

  /// Scaffold bottomNavigationBar
  final Widget? bottomNavigationBar;

  /// Below Scaffold background
  final Color? underneathBackgroundColor;

  /// Body padding
  final EdgeInsetsGeometry? padding;

  /// Floating Action Button
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// SafeArea related properties

  /// Apply SafeArea padding at top
  final bool isSafeAreaTop;

  /// Drawer safe area bottom
  final bool isDrawerSafeAreaBottom;

  /// Drawer safe area top
  final bool isDrawerSafeAreaTop;

  /// Apply SafeArea padding at bottom
  final bool isSafeAreaBottom;

  /// Pull-to-refresh callback
  final Function? onRefresh;

  /// If [resizeToAvoidBottomInset] = false
  /// then the body is not resized when the onscreen keyboard appears,
  final bool resizeToAvoidBottomInset;

  /// Callback when user tries to pop (back navigation).
  /// Return `true` to allow pop, `false` to prevent.
  final bool canPop;
  final void Function(bool didPop, Object? result)? onPopInvokedWithResult;

  const NavigationRailPlus({
    super.key,
    required this.navigationLeadingConfig,

    this.externalScaffoldKey,
    this.selectedIndex = 0,

    this.responsiveBody,
    this.navigationHeaderConfig,
    this.navigationGlobalConfig,
    this.navigationMainContent,
    this.navigationFooterConfig,
    this.onDestinationSelected,

    ///----------------------------------------------------
    /// Scaffold data/variable section
    ///----------------------------------------------------

    // App bar related
    this.appBar,
    this.appBarText,
    this.appBarActions,
    this.appBarTextStyle,
    this.appBarBackButton,
    this.appBarTitleSpacing,
    this.appBarBackButtonTap,
    this.appBarBackgroundColor,
    this.appBarBottomRxLoading,
    this.appBarBackButtonColor,
    this.appBarCenterTitle = false,
    this.appBarBottomLoading = false,
    this.appBarBottomDivider = false,
    this.needOverlayStyle = true,
    this.extendBodyBehindAppBar = false,
    this.appBarForceMaterialTransparency,

    // Bottom sheet related
    this.bottomSheet,
    this.bottomSheetPaddingBottom,
    this.bottomSheetLoadingBuilder,
    this.bottomSheetBackgroundColor,
    this.bottomSheetNeedFullWidth = true,
    this.bottomSheetMaxWidth,
    this.appBarMaxWidth,

    // Builders for dynamic UI states
    this.bodyBuilder,
    this.bodyMaxWidth,
    this.errorBuilder,
    this.loadingBuilder,
    this.noContentToShowBuilder,
    this.isNoContentToShow = false,
    this.isContentFailed = false,
    this.isContentLoading = false,

    // Scaffold related
    this.padding,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.underneathBackgroundColor,

    // Floating action button related
    this.floatingActionButton,
    this.floatingActionButtonLocation,

    // SafeArea related
    this.isDrawerSafeAreaBottom = true,
    this.isDrawerSafeAreaTop = true,
    this.isSafeAreaTop = false,
    this.isSafeAreaBottom = true,

    // Refresh related
    this.onRefresh,

    // Pop scop related
    this.canPop = true,
    this.onPopInvokedWithResult,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  State<NavigationRailPlus> createState() => _NavigationRailPlusState();
}

class _NavigationRailPlusState extends State<NavigationRailPlus> {
  /// Scaffold key base on user key given
  GlobalKey<ScaffoldState>? scaffoldKey;

  /// Index of the item currently hovered by mouse (used for hover UI state)
  int? hoveredIndex;

  /// Controls visibility of divider based on scroll position
  bool showDivider = false;

  /// Fallback animation duration when not provided via config
  Duration animationDuration = Duration(milliseconds: 250);

  // Scroll controller for handle scrollable items
  ScrollController scrollController = ScrollController();

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
  List<NavigationRailPlusDestination> get _allDestinations {
    return [
      ...widget.navigationLeadingConfig.fixLeadingItems,
      ...?widget.navigationLeadingConfig.scrollableLeadingItems,
    ];
  }

  @override
  void initState() {
    super.initState();

    /// Add scaffold key base on 2 option
    /// 1. Use external key
    /// 2. Use default key
    scaffoldKey = widget.externalScaffoldKey ?? GlobalKey<ScaffoldState>();

    /// Listen to scroll offset to determine divider visibility
    scrollController.addListener(() {
      bool shouldShow =
          scrollController.hasClients && scrollController.offset > 4;

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
    scrollController.dispose();
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
        return CustomScaffold(
          canPop: widget.canPop,
          scaffoldKey: scaffoldKey,
          onPopInvokedWithResult: widget.onPopInvokedWithResult,
          isSafeAreaTop: widget.isSafeAreaTop,
          isSafeAreaBottom: widget.isSafeAreaBottom,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
          appBarText: widget.appBarText,
          appBarActions: widget.appBarActions,
          appBarTextStyle: widget.appBarTextStyle,
          appBarBackButton: widget.appBarBackButton,
          appBarTitleSpacing: widget.appBarTitleSpacing,
          appBarBackButtonTap: widget.appBarBackButtonTap,
          appBarBackgroundColor: widget.appBarBackButtonColor,
          appBarBottomRxLoading: widget.appBarBottomRxLoading,
          appBarBackButtonColor: widget.appBarBackButtonColor,
          appBarCenterTitle: widget.appBarCenterTitle,
          appBarBottomLoading: widget.appBarBottomLoading,
          appBarBottomDivider: widget.appBarBottomDivider,
          needOverlayStyle: widget.needOverlayStyle,
          appBarForceMaterialTransparency:
              widget.appBarForceMaterialTransparency,
          bottomSheet: widget.bottomSheet,
          bottomSheetPaddingBottom: widget.bottomSheetPaddingBottom,
          bottomSheetLoadingBuilder: widget.bottomSheetLoadingBuilder,
          bottomSheetBackgroundColor: widget.bottomSheetBackgroundColor,
          bottomSheetNeedFullWidth: widget.bottomSheetNeedFullWidth,
          bottomSheetMaxWidth: widget.bottomSheetMaxWidth,
          appBarMaxWidth: widget.appBarMaxWidth,
          bodyMaxWidth: widget.bodyMaxWidth,
          errorBuilder: widget.errorBuilder,
          loadingBuilder: widget.loadingBuilder,
          noContentToShowBuilder: widget.noContentToShowBuilder,
          isNoContentToShow: widget.isNoContentToShow,
          isContentFailed: widget.isContentFailed,
          isContentLoading: widget.isContentLoading,
          padding: widget.padding,
          backgroundColor: widget.backgroundColor,
          bottomNavigationBar: widget.bottomNavigationBar,
          underneathBackgroundColor: widget.underneathBackgroundColor,
          floatingActionButton: widget.floatingActionButton,
          floatingActionButtonLocation: widget.floatingActionButtonLocation,
          onRefresh: widget.onRefresh,
          appBar:
              widget.appBar ??
              AppBar(
                forceMaterialTransparency:
                    widget.appBarForceMaterialTransparency ?? true,
                bottom: BottomAppBarSection(
                  isLoading: widget.appBarBottomLoading ?? false,
                  isDivider: widget.appBarBottomDivider ?? false,
                  rxLoading: widget.appBarBottomRxLoading,
                ),
                centerTitle: widget.appBarCenterTitle,
                backgroundColor: widget.appBarBackgroundColor,
                actions: widget.appBarActions,
                titleSpacing: widget.appBarTitleSpacing,
                title: widget.appBarText != null
                    ? Text(
                        widget.appBarText ?? '',
                        style: widget.appBarTextStyle,
                      )
                    : null,

                /// Opens navigation drawer
                leading:
                    widget.appBarBackButton ??
                    IconButton(
                      icon: Icon(CupertinoIcons.line_horizontal_3),
                      onPressed:
                          widget.appBarBackButtonTap ??
                          () => scaffoldKey?.currentState?.openDrawer(),
                    ),
              ),
          drawer: _drawerBodyContent,
          bodyBuilder:
              widget.bodyBuilder ??
              (BuildContext context) =>
                  widget.responsiveBody ?? const SizedBox.shrink(),
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
        bottom: widget.isDrawerSafeAreaBottom,
        top: widget.isDrawerSafeAreaTop,
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
    List<NavigationRailPlusDestination> scrollableItems =
        widget.navigationLeadingConfig.scrollableLeadingItems ?? [];

    return ListView(
      padding: EdgeInsets.zero,
      controller: scrollController,
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
    NavigationRailPlusDestination item = _allDestinations[index];

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
        (widget.navigationGlobalConfig?.closeOnSelectDrawerItem ?? true) &&
        Navigator.of(context).canPop();

    bool isMobile = context.screenType == DeviceScreenType.mobile;

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
          borderRadius: controller.globalConfig.globalBorderRadius * 2,
          onTap: item.disabled
              ? null
              : () {
                  /// Notify parent
                  widget.onDestinationSelected?.call(index);

                  /// Close drawer if required
                  if (canPop) scaffoldKey?.currentState?.closeDrawer();
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
                message: !isMobile && widget.navigationLeadingConfig.needTooltip
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
