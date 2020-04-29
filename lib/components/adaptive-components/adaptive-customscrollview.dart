import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveCustomScrollView extends StatelessWidget {
  final Widget child;
  final ScrollController controller;
  final Widget navBar;
  final VoidCallback onRefresh;
  final Key key;
  final double absorber; //Sliveroverlapinjecotr yadiya

  AdaptiveCustomScrollView(
      {@required this.child,
      this.controller,
      this.navBar,
      this.absorber,
      this.key,
      this.onRefresh});

  Widget _buildiOS(BuildContext context) {
    return CustomScrollView(
      key: key,
      controller: controller,
      cacheExtent: MediaQuery.of(context).size.height,
      slivers: <Widget>[
        if (navBar != null) navBar,
        if (absorber != null)
          SliverPersistentHeader(
              delegate: _SliverPersistentHeaderDelegate(absorber: absorber)),
        if (onRefresh != null)
          CupertinoSliverRefreshControl(
            onRefresh: onRefresh,
          ),
        child,
      ],
      physics: child is SliverFillRemaining
          ? NeverScrollableScrollPhysics()
          : AlwaysScrollableScrollPhysics(),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return onRefresh != null
        ? RefreshIndicator(
            onRefresh: onRefresh,
            child: CustomScrollView(
                cacheExtent: MediaQuery.of(context).size.height,
                slivers: [
                  if (navBar != null) navBar,
                  if (absorber != null)
                    SliverPersistentHeader(
                        delegate: _SliverPersistentHeaderDelegate(
                            absorber: absorber)),
                  child
                ]))
        : CustomScrollView(
            cacheExtent: MediaQuery.of(context).size.height,
            slivers: [
                if (navBar != null) navBar,
                  if (absorber != null)
                    SliverPersistentHeader(
                        delegate: _SliverPersistentHeaderDelegate(
                            absorber: absorber)),
                child
              ]);
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildiOS(context) : _buildAndroid(context);
  }
}

class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double absorber;
  _SliverPersistentHeaderDelegate({this.absorber});
  @override
  double get minExtent => absorber;
  @override
  double get maxExtent => absorber;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: absorber,
    );
  }

  @override
  bool shouldRebuild(_SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
