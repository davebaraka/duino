import 'dart:io';

import 'package:duino/components/adaptive-components/adaptive-material.dart';
import 'package:duino/models/bledevice-model.dart';
import 'package:duino/providers/bluetooth-provider.dart';
import 'package:duino/styles.dart';
import 'package:duino/views/connect-vieiw/components/dialog-component.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:provider/provider.dart';

// Display current bluetooth/connected device status.
class StatusComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BluetoothProvider bluetoothProvider =
        Provider.of<BluetoothProvider>(context);
    final BleDevice bleDevice = bluetoothProvider.bleDevice;
    final PeripheralConnectionState bleDeviceState =
        bluetoothProvider.bleDeviceState;
    final BluetoothState bluetoothState = bluetoothProvider.bluetoothState;

    if ((bluetoothState == BluetoothState.POWERED_ON ||
        bluetoothState == BluetoothState.UNKNOWN)) {
      switch (bleDeviceState) {
        case PeripheralConnectionState.disconnected:
          return _buildHeader(
            context: context,
            text: 'No Device Connected',
            backgroundColor: Styles.of(context).primaryContrastingColor,
            iconData: EvaIcons.minusCircleOutline,
            textColor: Styles.of(context).textStyle.color,
          );
        case PeripheralConnectionState.connecting:
          return _buildHeader(
            context: context,
            text: 'Connecting to ${bleDevice.name}',
            textColor: Styles.adaptiveWhiteColor,
            backgroundColor: Styles.adaptiveOrangeColor,
            iconData: EvaIcons.activityOutline,
          );
        case PeripheralConnectionState.disconnecting:
          return _buildHeader(
            context: context,
            text: 'Disconnecting from ${bleDevice.name}',
            textColor: Styles.adaptiveWhiteColor,
            backgroundColor: Styles.adaptiveOrangeColor,
            iconData: EvaIcons.activityOutline,
          );
        case PeripheralConnectionState.connected:
          return _buildHeader(
            context: context,
            text: 'Connected to ${bleDevice.name}',
            textColor: Styles.adaptiveWhiteColor,
            backgroundColor: Styles.adaptiveGreenColor,
            iconData: EvaIcons.checkmarkCircle,
          );
        default:
          return _buildHeader(
            context: context,
            text: 'No Device Connected',
            backgroundColor: Styles.of(context).primaryContrastingColor,
            iconData: EvaIcons.minusCircleOutline,
            textColor: Styles.of(context).textStyle.color,
          );
      }
    } else {
      switch (bluetoothState) {
        case BluetoothState.UNAUTHORIZED:
          return _buildHeader(
              context: context,
              text: 'Bluetooth Unauthorized',
              backgroundColor: Styles.of(context).primaryContrastingColor,
              iconData: EvaIcons.minusCircleOutline,
              textColor: Styles.of(context).textStyle.color);
        case BluetoothState.UNSUPPORTED:
          return _buildHeader(
              context: context,
              text: 'Bluetooth Unavailable',
              backgroundColor: Styles.of(context).primaryContrastingColor,
              iconData: EvaIcons.minusCircleOutline,
              textColor: Styles.of(context).textStyle.color);
        default:
          return _buildHeader(
              context: context,
              text: 'Bluetooth Off',
              backgroundColor: Styles.of(context).primaryContrastingColor,
              iconData: EvaIcons.minusCircleOutline,
              textColor: Styles.of(context).textStyle.color);
      }
    }
  }

  /// Builds a persistent header status for bluetooth state and device state.
  SliverPersistentHeader _buildHeader(
      {BuildContext context,
      String text,
      Color textColor,
      Color backgroundColor,
      IconData iconData}) {
    if (backgroundColor == Styles.adaptiveGreenColor) {
      return SliverPersistentHeader(
        pinned: true,
        delegate: _SliverPersistentHeaderDelegate(
          backgroundColor: backgroundColor,
          child: Theme(
            data: Theme.of(context).copyWith(splashColor: Colors.transparent),
            child: AdaptiveMaterial(
              child: InkWell(
                onTap: () async {
                  Platform.isIOS
                      ? await cupertinoDisconnectDialog(context)
                      : await androidDisconnectDialog(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 16,
                    ),
                    Icon(
                      iconData,
                      color: textColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        text,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Styles.of(context).textStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return SliverPersistentHeader(
          pinned: true,
          delegate: _SliverPersistentHeaderDelegate(
            backgroundColor: backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 16,
                ),
                Icon(
                  iconData,
                  color: textColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Styles.of(context).textStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ));
    }
  }
}

/// Persistent header layout .
class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final Color backgroundColor;

  _SliverPersistentHeaderDelegate(
      {@required this.child, @required this.backgroundColor});

  @override
  double get minExtent => 36;
  @override
  double get maxExtent => 36;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(height: 36, color: backgroundColor, child: child);
  }

  @override
  bool shouldRebuild(_SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
