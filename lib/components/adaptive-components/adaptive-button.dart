import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final BorderRadius borderRadius;
  final EdgeInsets padding;

  AdaptiveButton(
      {@required this.onPressed,
      @required this.child,
      this.color,
      this.padding,
      this.borderRadius});

  Widget _buildiOS(BuildContext context) {
    return CupertinoButton(
      borderRadius: borderRadius ?? BorderRadius.circular(8.0),
      color: color,
      minSize: 0,
      padding: padding ?? EdgeInsets.only(),
      child: child,
      onPressed: onPressed,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(8.0),
      ),
      color: color,
      onPressed: onPressed,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildiOS(context) : _buildAndroid(context);
  }
}
