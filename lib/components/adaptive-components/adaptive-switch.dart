import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveSwitch extends StatelessWidget{
  final ValueChanged<bool> onChanged;
  final bool value;

  AdaptiveSwitch({this.onChanged, @required this.value});

  Widget _buildiOS(context) {
    return CupertinoSwitch(value: value, onChanged: onChanged);
  }

  Widget _buildAndroid(context) {
    return Switch(
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildiOS(context) : _buildAndroid(context);
  }
}
