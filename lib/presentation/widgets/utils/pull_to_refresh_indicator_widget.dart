import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PullToRefreshIndicator extends StatelessWidget {
  final Future<void> Function()? onRefresh;

  const PullToRefreshIndicator({this.onRefresh, super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverRefreshControl(
      onRefresh: onRefresh,
      builder: (context, state, pulledExtent, pullDistance, pullHeight) {
        if (pulledExtent <= 20) return SizedBox(height: pulledExtent);

        final value = switch (state) {
          RefreshIndicatorMode.drag => pulledExtent / (pullHeight + 40),
          RefreshIndicatorMode.done => pulledExtent / (pullHeight + 40),
          _ => null,
        };

        return Center(
          child: Opacity(
            opacity: clampDouble(value ?? 1, 0, 1),
            child: Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircularProgressIndicator(),
                Flexible(
                  child: Text(
                    "Pull down to refresh",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
