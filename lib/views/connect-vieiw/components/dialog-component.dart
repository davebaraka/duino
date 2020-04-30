import 'package:duino/providers/bluetooth-provider.dart';
import 'package:duino/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

cupertinoConnectDialog(BuildContext context, BluetoothDevice device) async {
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
                  device.name != "" ? device.name : '(Unknown)',
                  style: Styles.of(context).textStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  device.id.id,
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
                  bluetoothProvider.connectDevice(device);
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

androidConnectDialog(BuildContext context, BluetoothDevice device) async {
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
                  device.name != "" ? device.name : '(Unknown)',
                  style: Styles.of(context).textStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  device.id.id,
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
                  bluetoothProvider.connectDevice(device);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}

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
                  bluetoothProvider.bluetoothDevice.name != ""
                      ? bluetoothProvider.bluetoothDevice.name
                      : '(Unknown)',
                  style: Styles.of(context).textStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  bluetoothProvider.bluetoothDevice.id.id,
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
                  bluetoothProvider.status = ConnectionStatus.DISCONNECTING;
                  try {
                    bluetoothProvider.notify();
                    bluetoothProvider.disconnectDevice();
                    bluetoothProvider.status = ConnectionStatus.NONE;
                    bluetoothProvider.notify();
                  } catch (e) {
                    bluetoothProvider.notify();
                    bluetoothProvider.status =
                        ConnectionStatus.ERRORDISCONNECTING;
                  }
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
                  bluetoothProvider.bluetoothDevice.name != ""
                      ? bluetoothProvider.bluetoothDevice.name
                      : '(Unknown)',
                  style: Styles.of(context).textStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  bluetoothProvider.bluetoothDevice.id.id,
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
                  bluetoothProvider.status = ConnectionStatus.DISCONNECTING;
                  try {
                    bluetoothProvider.notify();
                    bluetoothProvider.disconnectDevice();
                    bluetoothProvider.status = ConnectionStatus.NONE;
                    bluetoothProvider.notify();
                  } catch (e) {
                    bluetoothProvider.notify();
                    bluetoothProvider.status =
                        ConnectionStatus.ERRORDISCONNECTING;
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}

cupertinoWaitingDialog(BuildContext context) async {
  await showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Text('In progress'),
            content: SingleChildScrollView(
                child: Text(
              'Device is currently connecting or disconnecting. Please try again.',
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

androidWaitingDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (_) => AlertDialog(
            backgroundColor: Styles.of(context).primaryColor,
            title: Text('In progress'),
            content: SingleChildScrollView(
                child: Text(
              'Device is currently connecting or disconnecting. Please try again.',
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
