import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:navigation_rail_plus/res/global_config.dart';
import 'package:navigation_rail_plus/res/context_extension.dart';
import 'package:navigation_rail_plus/controller/navigation_rail_controller.dart';
import 'package:navigation_rail_plus/model/custom_navigation_rail_destination.dart';

class CustomNavigationRail extends StatefulWidget {
  // Header related variables
  final Widget? header;
  final Widget? headerIcon;
  final double? headerIconSize;
  final Color? headerIconColor;

  // Leading related data that handle section under header
  final Color? leadingColor;
  final Color? leadingHoverColor;
  final Color? selectedLeadingColor;
  final double? leadingIconSize;
  final EdgeInsets? leadingIconPadding;
  final List<CustomNavigationRailDestination> fixLeading;
  final List<CustomNavigationRailDestination>? scrollableLeading;

  // Handle widgets that are between leading and trailing section
  final List<Widget>? body;

  // Footer and trailing variables
  final Widget? footer;
  final Widget? trailing;

  final Color? backgroundColor;

  // Handle on item click
  final int? selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  const CustomNavigationRail({
    super.key,
    this.header,
    this.headerIcon,
    this.headerIconSize,
    this.headerIconColor,
    required this.fixLeading,
    this.scrollableLeading,
    this.body,
    this.footer,
    this.trailing,
    this.backgroundColor,
    this.selectedIndex = 0,
    this.onDestinationSelected,
    this.leadingColor,
    this.leadingIconSize,
    this.leadingHoverColor,
    this.leadingIconPadding,
    this.selectedLeadingColor,
  });

  @override
  State<CustomNavigationRail> createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends State<CustomNavigationRail> {
  int? hoveredIndex;
  bool showDivider = false;

  GlobalConfig globalConfig = GlobalConfig();

  NavigationRailController navigationRailController = Get.put(
    NavigationRailController(),
    tag: GlobalConfig().navRailControllerKey,
  );

  List<CustomNavigationRailDestination> get _allDestinations {
    return [...widget.fixLeading, ...?widget.scrollableLeading];
  }

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Handle divider showing by scroll offset that change with user scrolling
    scrollController.addListener(() {
      bool shouldShow = scrollController.offset > 0;

      if (shouldShow != showDivider) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() => showDivider = shouldShow);
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedSize(
        curve: Curves.easeInOut,
        duration: navigationRailController.animationDuration,
        alignment: Alignment.topCenter,
        child: Container(
          width: navigationRailController.isNavExpanded.value
              ? navigationRailController.expandedWidth
              : navigationRailController.normalWidth,
          color: widget.backgroundColor,
          child: Column(
            crossAxisAlignment: .center,
            children: [
              const SizedBox(height: 8),

              // Header section
              headerSection,

              // Fix leading section
              const SizedBox(height: 8),
              fixedLeadingSection,

              // Divider key
              if (widget.scrollableLeading != null &&
                  navigationRailController.isNavExpanded.value) ...[
                fixedDivider,
              ],

              // Body section
              Expanded(child: scrollableSection),

              // Trailing section
              if (widget.trailing != null) ...[
                widget.trailing!,
                SizedBox(
                  height: navigationRailController.isNavExpanded.value ? 8 : 16,
                ),
              ],

              // Footer section
              if (navigationRailController.isNavExpanded.value) ...[
                widget.footer ?? const SizedBox.shrink(),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      );
    });
  }

  Widget get headerSection {
    return Column(
      children: [
        if (navigationRailController.isNavExpanded.value) ...[
          widget.header ?? const SizedBox(height: 16),
        ] else ...[
          if (widget.headerIcon != null) ...[
            widget.headerIcon!,
          ] else ...[
            IconButton(
              onPressed: navigationRailController.toggleNavigationRail,
              icon: Icon(Icons.menu, size: 25),
            ),
          ],
        ],
      ],
    );
  }

  Widget get fixedLeadingSection {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: widget.fixLeading.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => _buildDestinationItem(index),
    );
  }

  Widget get scrollableSection {
    List<CustomNavigationRailDestination> scrollableItems =
        widget.scrollableLeading ?? [];

    return ListView(
      padding: EdgeInsets.zero,
      controller: scrollController,
      children: [
        for (int i = 0; i < scrollableItems.length; i++) ...[
          _buildDestinationItem(widget.fixLeading.length + i),
        ],

        if (widget.body != null &&
            navigationRailController.isNavExpanded.value) ...[
          Opacity(
            opacity: showDivider ? 0 : 1,
            child: Padding(
              padding: globalConfig.globalMargin,
              child: Divider(
                thickness: 0.5,
                color: context.appColorScheme.outlineVariant,
              ),
            ),
          ),
          ...widget.body!,
        ],
      ],
    );
  }

  Widget _buildDestinationItem(int index) {
    CustomNavigationRailDestination item = _allDestinations[index];

    bool isHovered = hoveredIndex == index;
    bool isSelected = widget.selectedIndex == index;

    Color leadingColor = widget.leadingColor ?? context.appColorScheme.shadow;

    Color selectedLeadingColor =
        widget.selectedLeadingColor ?? context.appColorScheme.shadow;

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
        duration: navigationRailController.animationDuration,
        decoration: BoxDecoration(
          borderRadius: globalConfig.globalBorderRadius * 2,
          color: isHovered || (isSelected && index != 0)
              ? (widget.leadingHoverColor ??
                    context.appColorScheme.outlineVariant.withValues(
                      alpha: 0.2,
                    ))
              : null,
        ),
        margin: globalConfig.globalMargin * 2,
        child: InkWell(
          onTap: item.disabled
              ? null
              : () {
                  if (widget.onDestinationSelected != null) {
                    widget.onDestinationSelected!(index);
                  }
                },
          child: Opacity(
            opacity: item.disabled ? 0.5 : 1,
            child: Padding(
              padding:
                  widget.leadingIconPadding ??
                  EdgeInsets.symmetric(
                    horizontal: globalConfig.symmetricMargin.horizontal,
                    vertical: globalConfig.symmetricMargin.vertical * 3,
                  ),
              child: Row(
                mainAxisAlignment: navigationRailController.isNavExpanded.value
                    ? .start
                    : .center,
                crossAxisAlignment: .center,
                children: [
                  Flexible(
                    child: Icon(
                      isSelected && item.selectedIcon != null
                          ? item.selectedIcon
                          : item.icon,
                      size: widget.leadingIconSize ?? context.mediumIcon,
                      color: isSelected ? selectedLeadingColor : leadingColor,
                    ),
                  ),
                  if (navigationRailController.isNavExpanded.value) ...[
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
    );
  }

  Widget get fixedDivider {
    return Padding(
      padding: globalConfig.globalMargin,
      child: AnimatedOpacity(
        duration: navigationRailController.animationDuration,
        opacity: showDivider ? 1 : 0,
        child: Divider(
          height: 0,
          thickness: 0.5,
          color: context.appColorScheme.outlineVariant,
        ),
      ),
    );
  }
}
