import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:navigation_rail_plus/res/context_extension.dart';
import 'package:navigation_rail_plus/res/global_config.dart';
import 'package:navigation_rail_plus/widget/scaffold/bottom_app_bar_section.dart';
import 'package:navigation_rail_plus/widget/scaffold/custom_back_button.dart';
import 'package:navigation_rail_plus/widget/scaffold/custom_bottom_sheet.dart';

/// A highly customizable scaffold wrapper
class CustomScaffold extends StatelessWidget {
  /// Scaffold key for controlling drawer programmatically
  final GlobalKey<ScaffoldState>? scaffoldKey;

  /// AppBar related properties

  /// If you don't need appBar at all
  final bool needNoAppBar;

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

  /// Drawer section
  final Widget? drawer;

  const CustomScaffold({
    super.key,
    this.scaffoldKey,

    /// App bar related
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
    this.needNoAppBar = false,
    this.appBarCenterTitle = false,
    this.appBarBottomLoading = false,
    this.appBarBottomDivider = false,
    this.needOverlayStyle = true,
    this.extendBodyBehindAppBar = false,
    this.appBarForceMaterialTransparency,

    /// Bottom sheet related
    this.bottomSheet,
    this.bottomSheetPaddingBottom,
    this.bottomSheetLoadingBuilder,
    this.bottomSheetBackgroundColor,
    this.bottomSheetNeedFullWidth = true,
    this.bottomSheetMaxWidth,
    this.appBarMaxWidth,

    /// Builders for dynamic UI states
    this.bodyBuilder,
    this.bodyMaxWidth,
    this.errorBuilder,
    this.loadingBuilder,
    this.noContentToShowBuilder,
    this.isNoContentToShow = false,
    this.isContentFailed = false,
    this.isContentLoading = false,

    /// Scaffold related
    this.padding,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.underneathBackgroundColor,

    /// Floating action button related
    this.floatingActionButton,
    this.floatingActionButtonLocation,

    /// SafeArea related
    this.isSafeAreaTop = false,
    this.isSafeAreaBottom = true,

    /// Refresh related
    this.onRefresh,

    /// Pop scop related
    this.canPop = true,
    this.onPopInvokedWithResult,
    this.resizeToAvoidBottomInset = true,

    /// Drawer variable
    this.drawer,
  });

  /// Refresh handler for pull-to-refresh
  Future<void> _handleRefresh() async {
    if (onRefresh != null) {
      onRefresh!();
    }
  }

  Color _getUnderneathBackgroundColor(BuildContext context) {
    /// If has precise underneathBackgroundColor
    if (underneathBackgroundColor != null) {
      return underneathBackgroundColor!;
    }

    /// If has bottomSheet
    if (bottomSheet != null) {
      return bottomSheetBackgroundColor ??
          context.bottomSheetTheme.backgroundColor ??
          context.appColorScheme.surface;
    }

    /// Otherwise
    return context.appColorScheme.surface;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _getUnderneathBackgroundColor(context),
      child: PopScope(
        canPop: canPop,
        onPopInvokedWithResult: onPopInvokedWithResult,
        child: SafeArea(
          top: isSafeAreaTop,
          bottom: isSafeAreaBottom,
          child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            appBar: needNoAppBar
                ? null
                : appBar != null
                ? PreferredSize(
                    preferredSize: appBar!.preferredSize,
                    child: _wrapWithMaxWidth(
                      maxWidth: appBarMaxWidth,
                      child: appBar!,
                    ),
                  )
                : AppBar(
                    title: Text(
                      appBarText ?? '',
                      style:
                          appBarTextStyle ?? context.appTextTheme.titleMedium,
                    ),
                    leading: CustomBackButton(
                      onTap:
                          appBarBackButtonTap ??
                          () => Navigator.of(context).pop(),
                      icon: appBarBackButton,
                    ),
                    backgroundColor:
                        appBarBackgroundColor ??
                        backgroundColor ??
                        context.theme.scaffoldBackgroundColor,
                    centerTitle: appBarCenterTitle,
                    actions: appBarActions,
                    bottom: BottomAppBarSection(
                      isLoading: appBarBottomLoading ?? false,
                      isDivider: appBarBottomDivider ?? false,
                      rxLoading: appBarBottomRxLoading,
                    ),
                    titleSpacing: appBarTitleSpacing,
                    forceMaterialTransparency:
                        appBarForceMaterialTransparency ?? true,
                    systemOverlayStyle: needOverlayStyle
                        ? getSystemOverlayStyle(context: context)
                        : null,
                  ),
            body: Container(
              padding: padding ?? EdgeInsets.zero,
              child: RefreshIndicator(
                strokeWidth: 2,
                color: context.appColorScheme.primaryContainer,
                backgroundColor: context.appColorScheme.primary,
                onRefresh: () async {
                  return await _handleRefresh();
                },
                notificationPredicate: (ScrollNotification notification) =>
                    onRefresh != null,
                child: _buildContent(context),
              ),
            ),
            bottomNavigationBar: bottomNavigationBar,
            backgroundColor: backgroundColor != null
                ? Color.alphaBlend(
                    backgroundColor!,
                    context.appColorScheme.surface,
                  )
                : context.theme.scaffoldBackgroundColor,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            drawer: drawer,
            bottomSheet: _buildBottomSheet(context),
          ),
        ),
      ),
    );
  }

  /// Build responsive or builds default or custom loading indicator
  Widget _buildLoadingIndicator(BuildContext context) {
    return loadingBuilder?.call(context) ??
        const Center(child: CircularProgressIndicator());
  }

  /// Build responsive or builds default or custom error builder
  Widget _buildError(BuildContext context) {
    return errorBuilder != null
        ? errorBuilder!(context)
        : const SizedBox.shrink();
  }

  /// Build responsive noContentToShow or builds default or custom no content to show
  Widget _buildNoContentToShow(BuildContext context) {
    return ListView(
      children: [
        noContentToShowBuilder != null
            ? noContentToShowBuilder!(context)
            : const SizedBox.shrink(),
      ],
    );
  }

  /// Build responsive or builds default or custom body builder
  Widget _buildBody(BuildContext context) {
    return bodyBuilder != null
        ? SizedBox(
            width: context.screenWidth,
            height: context.screenHeight,
            child: _wrapWithMaxWidth(
              maxWidth: bodyMaxWidth,
              child: bodyBuilder!(context),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _wrapWithMaxWidth({required Widget child, double? maxWidth}) {
    if (maxWidth == null) return child;
    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }

  /// Handles which content to show based on flags:
  /// - Loading
  /// - Error
  /// - No content
  /// - Main body
  Widget _buildContent(BuildContext context) {
    if (isContentLoading ?? false) {
      return _buildLoadingIndicator(context);
    }

    if (isContentFailed ?? false) {
      return _buildError(context);
    }

    if (isNoContentToShow ?? false) {
      /// Adding list view for enabling refreshing on no content
      return _buildNoContentToShow(context);
    }

    return _buildBody(context);
  }

  /// Builds BottomSheet depending on state (loading, success, or null)
  Widget? _buildBottomSheet(BuildContext context) {
    /// Failed content
    if (isContentFailed ?? false || (isNoContentToShow ?? false)) {
      return const SizedBox.shrink();
    }

    /// Loading content
    if (isContentLoading ?? false) {
      if (bottomSheetLoadingBuilder == null) {
        return const SizedBox.shrink();
      }

      return CustomBottomSheet(
        backgroundColor:
            bottomSheetBackgroundColor ??
            context.bottomSheetTheme.backgroundColor,
        paddingBottom: bottomSheetPaddingBottom,
        child: bottomSheetNeedFullWidth
            ? SizedBox(
                width: context.screenWidth,
                child: _wrapWithMaxWidth(
                  maxWidth: bottomSheetMaxWidth,
                  child: bottomSheetLoadingBuilder!(context),
                ),
              )
            : _wrapWithMaxWidth(
                maxWidth: bottomSheetMaxWidth,
                child: bottomSheetLoadingBuilder!(context),
              ),
      );
    }

    if (bottomSheet == null) return const SizedBox.shrink();

    /// Main content
    return CustomBottomSheet(
      backgroundColor:
          bottomSheetBackgroundColor ??
          context.bottomSheetTheme.backgroundColor,
      paddingBottom: bottomSheetPaddingBottom,
      child: bottomSheetNeedFullWidth
          ? SizedBox(
              width: context.screenWidth,
              child: _wrapWithMaxWidth(
                maxWidth: bottomSheetMaxWidth,
                child: bottomSheet!,
              ),
            )
          : _wrapWithMaxWidth(
              maxWidth: bottomSheetMaxWidth,
              child: bottomSheet!,
            ),
    );
  }
}
