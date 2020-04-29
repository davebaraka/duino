import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveActivityIndicator extends StatelessWidget {
  Widget _buildiOS() {
    return CupertinoActivityIndicator();
  }

  Widget _buildAndroid() {
    return SizedBox(
      child: CircularProgressIndicator(
        strokeWidth: 2,
      ),
      height: 24,
      width: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildiOS() : _buildAndroid();
  }
}
