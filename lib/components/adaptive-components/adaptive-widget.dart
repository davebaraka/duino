import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveWidget extends StatelessWidget {
  final Widget iOS;
  final Widget android;

  AdaptiveWidget({@required this.iOS, @required this.android});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? iOS : android;
  }
}
