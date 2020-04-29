import 'dart:io';

import 'package:duino/components/adaptive-components/adaptive-alertdialog.dart';
import 'package:duino/components/adaptive-components/adaptive-button.dart';
import 'package:duino/components/adaptive-components/adaptive-material.dart';
import 'package:duino/components/adaptive-components/adaptive-theme.dart';
import 'package:duino/providers/bluetooth-provider.dart';
import 'package:duino/styles.dart';
import 'package:duino/views/connect-vieiw/components/dialog-component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

class DeviceComponent extends StatelessWidget {
  final BluetoothDevice device;

  DeviceComponent({@required this.device});

  @override
  Widget build(BuildContext context) {
    BluetoothProvider bluetoothProvider =
        Provider.of<BluetoothProvider>(context, listen: false);
    return AdaptiveMaterial(
      child: AdaptiveTheme(
        themeData: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: InkWell(
          onTap: () async {
            if (bluetoothProvider.status == ConnectionStatus.DISCONNECTING ||
                bluetoothProvider.status == ConnectionStatus.CONNECTING) {
              Platform.isIOS ? await cupertinoWaitingDialog(context) : null;
            } else {
              if (bluetoothProvider.bluetoothDevice != null &&
                  this.device.id == bluetoothProvider.bluetoothDevice.id) {
                Platform.isIOS
                    ? await cupertinoDisconnectDialog(context)
                    : null;
              } else {
                Platform.isIOS
                    ? await cupertinoConnectDialog(context, device)
                    : null;
              }
            }
          },
          child: Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    device.name != "" ? device.name : '(Unknown)',
                    style: Styles.of(context).textStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    device.id.id,
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
