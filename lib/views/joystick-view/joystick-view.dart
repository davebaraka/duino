import 'dart:io';

import 'package:duino/components/adaptive-components/adaptive-iconbutton.dart';
import 'package:duino/components/adaptive-components/adaptive-navbar.dart';
import 'package:duino/components/adaptive-components/adaptive-scaffold.dart';
import 'package:duino/components/joystick-component.dart/joystick-component.dart';
import 'package:duino/components/state-component.dart';
import 'package:duino/components/util-components/math-util.dart';
import 'package:duino/providers/bluetooth-provider.dart';
import 'package:duino/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class JoystickView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BluetoothProvider bluetoothProvider =
        Provider.of<BluetoothProvider>(context, listen: false);
    return AdaptiveScaffold(
        navBar: AdaptiveNavBar(
          backgroundColor: Styles.of(context).barBackgroundColor,
          leading: AdaptiveIconButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                CupertinoIcons.back,
                color: Styles.of(context).textStyle.color,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          middle: Text(
            'Joystick',
            style: Styles.of(context).navTitleTextStyle,
          ),
          trailing: Padding(
            padding: Platform.isIOS
                ? const EdgeInsets.fromLTRB(0, 0, 16, 0)
                : EdgeInsets.only(),
            child: StateComponent(),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: JoystickComponent(
            interval: Duration(milliseconds: 75),
            onDirectionChanged: (double degrees, double distance) {
              String de;
              String di;
              de = degrees
                  .round()
                  .toStringAsFixed(0)
                  .padLeft(2, "00")
                  .padLeft(3, "0");
              di = MathUtil.map((distance * 1000), 0, 1000, 0, 255)
                  .toStringAsFixed(0)
                  .padLeft(2, "00")
                  .padLeft(3, "0");
              bluetoothProvider.write('$de$di#');
            },
            showArrows: false,
            backgroundColor: Styles.of(context).primaryContrastingColor,
            innerCircleColor: Styles.of(context).primaryColor,
          ),
        ));
  }
}
