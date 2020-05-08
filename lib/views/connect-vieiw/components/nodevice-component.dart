import 'package:duino/providers/bluetooth-provider.dart';
import 'package:duino/styles.dart';
import 'package:duino/views/connect-vieiw/providers/connect-provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:provider/provider.dart';

/// Display user feedback of connection discovery.
class NoDeviceComponent extends StatelessWidget {
  final String defaultMessage = "Discovered devices will show here.";
  final String androidMessage = "Location access is required to initiate scans for Bluetooth devices. Please allow \'Duino\' to access location in your device\'s settings.";
  final bool showDefaultMessage;
  final bool showAndroidMessage;

  NoDeviceComponent({this.showDefaultMessage, this.showAndroidMessage});

  @override
  Widget build(BuildContext context) {
    String message;
    BluetoothState bluetoothState =
        Provider.of<BluetoothProvider>(context).bluetoothState;
    bool isScanning = Provider.of<ConnectProvider>(context).isScanning;
    switch (bluetoothState) {
      case BluetoothState.UNAUTHORIZED:
        message =
            'Bluetooth permission denied. Please go to your device\'s settings and allow \'Duino\' to access Bluetooth.';
        break;
      case BluetoothState.UNKNOWN:
        message = showDefaultMessage ?? false
            ? defaultMessage
            : 'No devices discovered. Please make sure Bluetooth is on and you have allowed \'Duino\' to access Bluetooth in your device\'s settings.';
        break;
      case BluetoothState.UNSUPPORTED:
        message = 'Sorry, your device does not have Bluetooth.';
        break;
      case BluetoothState.POWERED_ON:
        message = showDefaultMessage ?? false
            ? defaultMessage
            : 'No devices discovered.';
        break;
      case BluetoothState.POWERED_OFF:
        message = 'Please turn on your device\'s Bluetooth.';
        break;
      case BluetoothState.RESETTING:
        message = 'Please turn on your device\'s Bluetooth.';
        break;
      default:
        message =
            'No devices discovered. Please make sure Bluetooth is on and you have allowed \'Duino\' to access Bluetooth in your device\'s settings.';
    }
    if (isScanning) message = 'Scanning...';
    if (showAndroidMessage ?? false) message = androidMessage;
    return Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Text(
          message,
          style: Styles.of(context).textStyle,
        ));
  }
}
