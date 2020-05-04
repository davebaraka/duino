import 'package:duino/models/bledevice-model.dart';
import 'package:duino/providers/bluetooth-provider.dart';
import 'package:duino/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// iOS Connect Dialog
cupertinoConnectDialog(BuildContext context, BleDevice bleDevice) async {
  BluetoothProvider bluetoothProvider =
      Provider.of<BluetoothProvider>(context, listen: false);
  await showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Text('Connect to'),
            content: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Text(
                  bleDevice.name,
                  style: Styles.of(context).textStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  bleDevice.id,
                  style: Styles.of(context)
                      .textStyle
                      .copyWith(color: Styles.adaptiveGrayColor, fontSize: 12),
                )
              ],
            )),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('Yes'),
                onPressed: () {
                  bluetoothProvider.connect(bleDevice);
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  'No',
                  style: Styles.of(context)
                      .textStyle
                      .copyWith(color: Styles.adaptiveRedColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}

// android Connect Dialog
androidConnectDialog(BuildContext context, BleDevice bleDevice) async {
  BluetoothProvider bluetoothProvider =
      Provider.of<BluetoothProvider>(context, listen: false);
  await showDialog(
      context: context,
      builder: (_) => AlertDialog(
            backgroundColor: Styles.of(context).primaryColor,
            title: Text('Connect to'),
            content: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  bleDevice.name,
                  style: Styles.of(context).textStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  bleDevice.id,
                  style: Styles.of(context)
                      .textStyle
                      .copyWith(color: Styles.adaptiveGrayColor, fontSize: 12),
                )
              ],
            )),
            actions: <Widget>[
              FlatButton(
                splashColor: Theme.of(context).splashColor,
                highlightColor: Theme.of(context).highlightColor,
                child: Text(
                  'No',
                  style: Styles.of(context)
                      .textStyle
                      .copyWith(color: Styles.adaptiveRedColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                splashColor: Theme.of(context).splashColor,
                highlightColor: Theme.of(context).highlightColor,
                child: Text(
                  'Yes',
                  style: TextStyle(color: Styles.adaptiveBlueColor),
                ),
                onPressed: () {
                  bluetoothProvider.connect(bleDevice);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}

// iOS Disconnect Dialog
cupertinoDisconnectDialog(BuildContext context) async {
  BluetoothProvider bluetoothProvider =
      Provider.of<BluetoothProvider>(context, listen: false);
  await showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Text('Disconnect from'),
            content: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Text(
                  bluetoothProvider.bleDevice.name,
                  style: Styles.of(context).textStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  bluetoothProvider.bleDevice.id,
                  style: Styles.of(context)
                      .textStyle
                      .copyWith(color: Styles.adaptiveGrayColor, fontSize: 12),
                )
              ],
            )),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('Yes'),
                onPressed: () {
                  bluetoothProvider.disconnect();
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  'No',
                  style: Styles.of(context)
                      .textStyle
                      .copyWith(color: Styles.adaptiveRedColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}

// android Disconnect Dialog
androidDisconnectDialog(BuildContext context) async {
  BluetoothProvider bluetoothProvider =
      Provider.of<BluetoothProvider>(context, listen: false);
  await showDialog(
      context: context,
      builder: (_) => AlertDialog(
            backgroundColor: Styles.of(context).primaryColor,
            title: Text('Disconnect from'),
            content: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  bluetoothProvider.bleDevice.name,
                  style: Styles.of(context).textStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  bluetoothProvider.bleDevice.id,
                  style: Styles.of(context)
                      .textStyle
                      .copyWith(color: Styles.adaptiveGrayColor, fontSize: 12),
                )
              ],
            )),
            actions: <Widget>[
              FlatButton(
                splashColor: Theme.of(context).splashColor,
                highlightColor: Theme.of(context).highlightColor,
                child: Text(
                  'No',
                  style: Styles.of(context)
                      .textStyle
                      .copyWith(color: Styles.adaptiveRedColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                splashColor: Theme.of(context).splashColor,
                highlightColor: Theme.of(context).highlightColor,
                child: Text(
                  'Yes',
                  style: TextStyle(color: Styles.adaptiveBlueColor),
                ),
                onPressed: () {
                  bluetoothProvider.disconnect();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}

// iOS Waiting Dialog
cupertinoWaitingDialog(BuildContext context) async {
  await showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Text('In progress'),
            content: SingleChildScrollView(
                child: Text(
              'Device is communicating. Please try again.',
              style: Styles.of(context).textStyle,
            )),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('Dismiss'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}

// android Waiting Dialog
androidWaitingDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (_) => AlertDialog(
            backgroundColor: Styles.of(context).primaryColor,
            title: Text('In progress'),
            content: SingleChildScrollView(
                child: Text(
              'Device is communicating. Please try again.',
              style: Styles.of(context).textStyle,
            )),
            actions: <Widget>[
              FlatButton(
                splashColor: Theme.of(context).splashColor,
                highlightColor: Theme.of(context).highlightColor,
                child: Text(
                  'Dismiss',
                  style: TextStyle(color: Styles.adaptiveBlueColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}
