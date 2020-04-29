import 'dart:io' show Platform;
import 'package:duino/components/adaptive-components/adaptive-material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveScaffold extends StatelessWidget {
  final Widget navBar;
  final Widget child;
  final Color backgroundColor;
  final bool safeAreaBottom;
  final bool safeAreaTop;

  AdaptiveScaffold(
      {this.navBar,
      @required this.child,
      this.backgroundColor,
      this.safeAreaBottom = false,
      this.safeAreaTop = false});

  Widget _buildiOS(context) {
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: navBar,
      child: SafeArea(
        top: safeAreaTop,
        bottom: safeAreaBottom,
        child: AdaptiveMaterial(child: child),
      ),
    );
  }

  Widget _buildAndroid(context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: navBar,
        body: SafeArea(bottom: safeAreaBottom, top: safeAreaTop, child: child));
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildiOS(context) : _buildAndroid(context);
  }
}
