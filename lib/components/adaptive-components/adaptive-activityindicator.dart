import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveActivityIndicator extends StatelessWidget {
  final Color color;
  AdaptiveActivityIndicator({this.color});
  Widget _buildiOS() {
    return CupertinoActivityIndicator(
      radius: 9.25,
    );
  }

  Widget _buildAndroid() {
    return SizedBox(
      child: CircularProgressIndicator(
        backgroundColor: color,
        strokeWidth: 2,
      ),
      height: 18.5,
      width: 18.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildiOS() : _buildAndroid();
  }
}
