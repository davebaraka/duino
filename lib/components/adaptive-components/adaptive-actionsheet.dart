import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveActionSheet extends StatelessWidget{
  final List<Widget> actions;
  final Widget cancelButton;
  final Widget title;
  final Widget message;

  AdaptiveActionSheet({@required this.actions, this.cancelButton, this.title, this.message});

  Widget _buildiOS(context) {
    return  CupertinoActionSheet(
        title: title,
        message: message,
        actions: actions,
        cancelButton: cancelButton);
  }

  Widget _buildAndroid(context) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildiOS(context) : _buildAndroid(context);
  }
}
