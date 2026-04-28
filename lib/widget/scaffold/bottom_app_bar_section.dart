import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../res/context_extension.dart';

class BottomAppBarSection extends StatefulWidget
    implements PreferredSizeWidget {
  final bool isLoading;
  final bool isDivider;
  final RxBool? rxLoading;

  const BottomAppBarSection({
    super.key,
    this.rxLoading,
    this.isLoading = false,
    this.isDivider = false,
  });

  @override
  final Size preferredSize = const Size.fromHeight(4);

  @override
  State<BottomAppBarSection> createState() => _BottomAppBarSectionState();
}

class _BottomAppBarSectionState extends State<BottomAppBarSection> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: widget.preferredSize,
      child: widget.rxLoading != null
          ? Obx(
              () => Column(
                children: [
                  if (widget.rxLoading!.value || widget.isLoading) ...[
                    const LinearProgressIndicator(),
                  ] else if (widget.isDivider) ...[
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: context.appColorScheme.primary.withValues(
                        alpha: 0.08,
                      ),
                    ),
                  ] else ...[
                    const SizedBox(height: 4),
                  ],
                ],
              ),
            )
          : Column(
              children: [
                if (widget.isLoading) ...[
                  const LinearProgressIndicator(),
                ] else if (widget.isDivider) ...[
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: context.appColorScheme.primary.withValues(
                      alpha: 0.08,
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: 4),
                ],
              ],
            ),
    );
  }
}
