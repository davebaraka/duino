import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveAlertDialog extends StatelessWidget {
  final List<Widget> actions;
  final Widget cancelButton;
  final Widget title;
  final Widget content;

  AdaptiveAlertDialog(
      {@required this.actions, this.cancelButton, this.title, this.content});

  Widget _buildiOS(context) {
    return CupertinoAlertDialog(
      title: title,
      content: content,
      actions: actions,
    );
  }

  Widget _buildAndroid(context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: actions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildiOS(context) : _buildAndroid(context);
  }
}
