import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveIconButton extends StatelessWidget {

  final VoidCallback onPressed;
  final Widget child;

  AdaptiveIconButton({@required this.onPressed, @required this.child});

  Widget _buildiOS(BuildContext context) {
    return CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.only(left: 16, right: 16),
      child: child,
      onPressed: onPressed,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildiOS(context) : _buildAndroid(context);
  }
}