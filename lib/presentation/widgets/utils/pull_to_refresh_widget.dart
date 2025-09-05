import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_poc/presentation/widgets/utils/pull_to_refresh_indicator_widget.dart';
import 'package:flutter_poc/presentation/widgets/utils/sliver_size_offset_widget.dart';

class PullToRefresh extends StatelessWidget {
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final ScrollBehavior? scrollBehavior;
  final bool shrinkWrap;
  final Key? center;
  final double anchor;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  final double? topOffset;

  final Future<void> Function()? onRefresh;
  final List<Widget> slivers;
  final Widget? appBar;

  const PullToRefresh({
    required this.slivers,
    this.onRefresh,
    this.appBar,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.scrollBehavior,
    this.shrinkWrap = false,
    this.center,
    this.anchor = 0.0,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.topOffset,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ScrollPhysics? parentPhysic;
    if (onRefresh != null) parentPhysic = const AlwaysScrollableScrollPhysics();

    return CustomScrollView(
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      physics: physics ?? BouncingScrollPhysics(parent: parentPhysic),
      scrollBehavior: scrollBehavior,
      shrinkWrap: shrinkWrap,
      center: center,
      anchor: anchor,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
      slivers: [
        if (appBar != null) appBar!,
        if (topOffset != null) SliverSizeOffset(size: topOffset),
        if (onRefresh != null) PullToRefreshIndicator(onRefresh: onRefresh),
        ...slivers,
      ],
    );
  }
}
