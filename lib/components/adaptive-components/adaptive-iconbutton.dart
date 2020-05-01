import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final BorderRadius borderRadius;
  final EdgeInsets padding;

  AdaptiveIconButton(
      {@required this.onPressed,
      @required this.child,
      this.padding,
      this.borderRadius,
      this.color});

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
    return SizedBox(
        height: 56,
        width: 56,
        child: ClipOval(
            child: Material(
          color: Colors.transparent, // button color
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Theme.of(context).splashColor, // splash color
            onTap: onPressed, // button pressed
            child: child,
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildiOS(context) : _buildAndroid(context);
  }
}
