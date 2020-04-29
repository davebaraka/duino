import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveMaterial extends StatelessWidget{
  final Widget child;

  AdaptiveMaterial({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: child,
    );
  }
}
