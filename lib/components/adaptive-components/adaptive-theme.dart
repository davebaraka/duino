import 'dart:io' show Platform;
import 'package:flutter/material.dart';

class AdaptiveTheme extends StatelessWidget {

  final ThemeData themeData;
  final Widget child;

  AdaptiveTheme({@required this.themeData, @required this.child});

  Widget _buildiOS(BuildContext context) {
    return Theme(
      data: themeData,
      child: child,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return child;
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildiOS(context) : _buildAndroid(context);
  }
}
