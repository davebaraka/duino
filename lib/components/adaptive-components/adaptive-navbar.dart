import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveNavBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget, PreferredSizeWidget {
  final Widget middle;
  final Widget largeTitle;
  final Widget leading;
  final Widget trailing;
  final bool implyLeading;
  final dynamic navbar;
  final Color backgroundColor;
  final double elevation;

  AdaptiveNavBar(
      {this.middle,
      this.elevation,
      this.backgroundColor,
      this.implyLeading = true,
      this.leading,
      this.largeTitle,
      this.trailing})
      : navbar = Platform.isIOS
            ? largeTitle != null
                ? CupertinoSliverNavigationBar(
                    leading: leading,
                    largeTitle: largeTitle,
                    middle: middle,
                    backgroundColor: backgroundColor,
                    trailing: trailing,
                    automaticallyImplyLeading: implyLeading,
                    border: null,
                  )
                : CupertinoNavigationBar(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    leading: leading,
                    middle: middle,
                    backgroundColor: backgroundColor,
                    trailing: trailing,
                    automaticallyImplyLeading: implyLeading,
                    border: null,
                  )
            : largeTitle != null
                ? SliverAppBar(
                    pinned: true,
                    forceElevated: true,
                    leading: leading,
                    title: largeTitle,
                    backgroundColor: backgroundColor,
                    actions: trailing != null ? [trailing] : [],
                    centerTitle: true,
                    automaticallyImplyLeading: implyLeading,
                  )
                : AppBar(
                    elevation: elevation ?? 4,
                    leading: leading,
                    title: middle,
                    backgroundColor: backgroundColor,
                    actions: trailing != null ? [trailing] : [],
                    centerTitle: true,
                    automaticallyImplyLeading: implyLeading,
                  );

  @override
  Widget build(BuildContext context) {
    return navbar;
  }

  @override
  Size get preferredSize => navbar.preferredSize;

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return navbar.shouldFullyObstruct(context);
  }
}
