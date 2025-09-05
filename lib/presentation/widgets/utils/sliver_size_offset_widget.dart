import 'package:flutter/material.dart';

class SliverSizeOffset extends StatelessWidget {
  final double? size;

  const SliverSizeOffset({required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _FixedSizeDelegate(size: size ?? 0),
    );
  }
}

class _FixedSizeDelegate extends SliverPersistentHeaderDelegate {
  final double size;

  const _FixedSizeDelegate({required this.size});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) =>
      const SizedBox();

  @override
  double get maxExtent => size;

  @override
  double get minExtent => size;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
