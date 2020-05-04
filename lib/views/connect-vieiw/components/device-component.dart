import 'dart:io';

import 'package:duino/components/adaptive-components/adaptive-material.dart';
import 'package:duino/components/adaptive-components/adaptive-theme.dart';
import 'package:duino/models/bledevice-model.dart';
import 'package:duino/providers/bluetooth-provider.dart';
import 'package:duino/styles.dart';
import 'package:duino/views/connect-vieiw/components/dialog-component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:provider/provider.dart';

/// Device list item.
class DeviceComponent extends StatelessWidget {
  final BleDevice bleDevice;

  DeviceComponent({@required this.bleDevice});

  @override
  Widget build(BuildContext context) {
    BluetoothProvider bluetoothProvider =
        Provider.of<BluetoothProvider>(context, listen: false);
    return AdaptiveMaterial(
      child: AdaptiveTheme(
        themeData: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: InkWell(
          onTap: () async {
            if (bluetoothProvider.bleDeviceState ==
                    PeripheralConnectionState.disconnecting ||
                bluetoothProvider.bleDeviceState ==
                    PeripheralConnectionState.connecting) {
              Platform.isIOS
                  ? await cupertinoWaitingDialog(context)
                  : await androidWaitingDialog(context);
            } else {
              if (bluetoothProvider.bleDevice != null &&
                  bleDevice.id == bluetoothProvider.bleDevice.id) {
                Platform.isIOS
                    ? await cupertinoDisconnectDialog(context)
                    : await androidDisconnectDialog(context);
              } else {
                Platform.isIOS
                    ? await cupertinoConnectDialog(context, bleDevice)
                    : await androidConnectDialog(context, bleDevice);
              }
            }
          },
          child: Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    bleDevice.name,
                    style: Styles.of(context).textStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    bleDevice.id,
                    style: Styles.of(context).textStyle.copyWith(
                        color: Styles.adaptiveGrayColor, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
