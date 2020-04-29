import 'package:duino/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoDeviceComponent extends StatelessWidget {
  final String message;
  NoDeviceComponent({@required this.message});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Text(
          message,
          style: Styles.of(context).textStyle,
        ));
  }
}
