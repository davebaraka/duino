import 'dart:async';
import 'dart:math';

import 'package:duino/providers/bluetooth-provider.dart';
import 'package:duino/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensors/sensors.dart';

class RingComponent extends StatefulWidget {
  @override
  _RingComponentState createState() => _RingComponentState();
}

class _RingComponentState extends State<RingComponent> {
  AccelerometerEvent accelerometerEvent;
  StreamSubscription<AccelerometerEvent> accelerometerStream;
  double roll = 0;
  double pitch = 0;

  String normalize(int value) {
    if (value < 0) {
      String tmp = value
          .toString()
          .substring(1)
          .padLeft(2, "00")
          .padLeft(3, "0")
          .padLeft(4, "-");
      return tmp;
    } else {
      return value
          .toString()
          .padLeft(2, "000")
          .padLeft(3, "00")
          .padLeft(4, "0");
    }
  }

  @override
  void initState() {
    super.initState();
    BluetoothProvider bluetoothProvider =
        Provider.of<BluetoothProvider>(context, listen: false);
    accelerometerStream =
        accelerometerEvents.listen((AccelerometerEvent event) {
      double tmpRoll = (atan2(event.y, event.z) * 180 / pi);
      double tmpPitch =
          (atan2(-event.x, sqrt(event.y * event.y + event.z * event.z)) *
              180 /
              pi);
      if (roll != tmpRoll || pitch != tmpPitch) {
        setState(() {
          roll = tmpRoll;
          pitch = tmpPitch;

          String r = normalize(roll.round());
          String p = normalize(pitch.round());

          bluetoothProvider.write('($r,$p)#');
        });
      }
    });
  }

  @override
  void dispose() {
    accelerometerStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(roll * (pi / 180))
          ..rotateY(pitch * 2 * (pi / 180)),
        child: Container(
          width: MediaQuery.of(context).size.width * .75,
          height: MediaQuery.of(context).size.width * .75,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF9B32FE),
                    Color(0xFF5B6BEB),
                    Color(0xFF0FAED4)
                  ])),
          child: Center(
              child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Styles.of(context).barBackgroundColor,
            ),
            height: MediaQuery.of(context).size.width * .65,
            width: MediaQuery.of(context).size.width * .65,
          )),
        ),
      ),
    );
  }
}
