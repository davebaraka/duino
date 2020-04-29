import 'dart:io';

import 'package:duino/components/adaptive-components/adaptive-material.dart';
import 'package:duino/providers/bluetooth-provider.dart';
import 'package:duino/styles.dart';
import 'package:duino/views/connect-vieiw/components/dialog-component.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class StatusComponent extends StatelessWidget {
  final BluetoothDevice device;
  final ConnectionStatus status;
  final BluetoothState state;

  StatusComponent(
      {@required this.device, @required this.status, @required this.state});

  @override
  Widget build(BuildContext context) {
    if (state != BluetoothState.on) {
      String text = "Bluetooth Off";
      switch (state) {
        case BluetoothState.unauthorized:
          text = 'Bluetooth Unauthorized';
          break;
        case BluetoothState.unavailable:
          text = 'Bluetooth Unavailable';
          break;
        case BluetoothState.unknown:
          text = 'Unable to connect to bluetooth.';
          break;
        default:
          break;
      }
      return SliverPersistentHeader(
          pinned: true,
          delegate: _SliverPersistentHeaderDelegate(
            backgroundColor: Styles.of(context).primaryContrastingColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 16,
                ),
                Icon(
                  EvaIcons.minusCircleOutline,
                  color: Styles.of(context).textStyle.color,
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
                        color: Styles.of(context).textStyle.color),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ));
    } else {
      switch (status) {
        case ConnectionStatus.NONE:
          return SliverPersistentHeader(
              pinned: true,
              delegate: _SliverPersistentHeaderDelegate(
                backgroundColor: Styles.of(context).primaryContrastingColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 16,
                    ),
                    Icon(
                      EvaIcons.minusCircleOutline,
                      color: Styles.of(context).textStyle.color,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        'No Device Connected',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Styles.of(context).textStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Styles.of(context).textStyle.color),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              ));
        case ConnectionStatus.CONNECTING:
          String deviceName = device.name != "" ? device.name : '(Unknown)';
          return SliverPersistentHeader(
              pinned: true,
              delegate: _SliverPersistentHeaderDelegate(
                backgroundColor: Styles.warningBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 16,
                    ),
                    Icon(
                      EvaIcons.activity,
                      color: Styles.warningTextColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        'Connecting to $deviceName',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Styles.of(context).textStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Styles.warningTextColor),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              ));
        case ConnectionStatus.DISCONNECTING:
          String deviceName = device.name != "" ? device.name : '(Unknown)';
          return SliverPersistentHeader(
              pinned: true,
              delegate: _SliverPersistentHeaderDelegate(
                backgroundColor: Styles.warningBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 16,
                    ),
                    Icon(
                      EvaIcons.activity,
                      color: Styles.warningTextColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        'Disconnecting from $deviceName',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Styles.of(context).textStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Styles.warningTextColor),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              ));
        case ConnectionStatus.ERRORCONNECTING:
          String deviceName = device.name != "" ? device.name : '(Unknown)';
          return SliverPersistentHeader(
              pinned: true,
              delegate: _SliverPersistentHeaderDelegate(
                backgroundColor: Styles.dangerBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 16,
                    ),
                    Icon(
                      EvaIcons.closeCircleOutline,
                      color: Styles.dangerTextColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        'Unable to connect to $deviceName',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Styles.of(context).textStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Styles.dangerTextColor),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              ));
        case ConnectionStatus.ERRORDISCONNECTING:
          String deviceName = device.name != "" ? device.name : '(Unknown)';
          return SliverPersistentHeader(
              pinned: true,
              delegate: _SliverPersistentHeaderDelegate(
                backgroundColor: Styles.dangerBackgroundColor,
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(splashColor: Colors.transparent),
                  child: AdaptiveMaterial(
                    child: InkWell(
                      onTap: () async {
                        Platform.isIOS
                            ? await cupertinoDisconnectDialog(context)
                            : androidDisconnectDialog(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          Icon(
                            EvaIcons.closeCircleOutline,
                            color: Styles.dangerTextColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              'Unable to disconnect from $deviceName',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Styles.of(context).textStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Styles.dangerTextColor),
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
              ));
        case ConnectionStatus.CONNECTED:
          String deviceName = device.name != "" ? device.name : '(Unknown)';
          return SliverPersistentHeader(
              pinned: true,
              delegate: _SliverPersistentHeaderDelegate(
                backgroundColor: Styles.successBackgroundColor,
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(splashColor: Colors.transparent),
                  child: AdaptiveMaterial(
                    child: InkWell(
                      onTap: () async {
                        Platform.isIOS
                            ? await cupertinoDisconnectDialog(context)
                            : androidDisconnectDialog(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          Icon(
                            EvaIcons.checkmarkCircle,
                            color: Styles.successTextColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              'Connected to $deviceName',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Styles.of(context).textStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Styles.successTextColor),
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
              ));
        default:
          return null;
      }
    }
  }
}

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
