import 'package:duino/components/adaptive-components/adaptive-activityindicator.dart';
import 'package:duino/components/adaptive-components/adaptive-iconbutton.dart';
import 'package:duino/components/adaptive-components/adaptive-navbar.dart';
import 'package:duino/components/adaptive-components/adaptive-scaffold.dart';
import 'package:duino/providers/bluetooth-provider.dart';
import 'package:duino/styles.dart';
import 'package:duino/views/connect-vieiw/components/nodevice-component.dart';
import 'package:duino/views/connect-vieiw/components/status-component.dart';
import 'package:duino/views/connect-vieiw/providers/connect-provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:provider/provider.dart';

/// Connect screen.
class ConnectView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConnectProvider _connectProvider = Provider.of<ConnectProvider>(context);
    return AdaptiveScaffold(
        navBar: AdaptiveNavBar(
          backgroundColor: Styles.of(context).barBackgroundColor,
          middle: Text(
            'Connect',
            style: Styles.of(context).navTitleTextStyle,
          ),
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
        ),
        backgroundColor: Styles.of(context).scaffoldBackgroundColor,
        child: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            cacheExtent: MediaQuery.of(context).size.height,
            slivers: <Widget>[
              StatusComponent(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Devices',
                        style: Styles.of(context).textStyle.copyWith(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 28,
                        padding: EdgeInsets.only(),
                        child: CupertinoButton(
                            padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                            onPressed: () async {
                              await _connectProvider.startScan(
                                  Provider.of<BluetoothProvider>(context,
                                      listen: false));
                            },
                            child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: _connectProvider.isScanning
                                      ? AdaptiveActivityIndicator(
                                          color: Styles.of(context)
                                              .textStyle
                                              .color,
                                        )
                                      : Text(
                                          'Scan',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: Styles.of(context)
                                              .textStyle
                                              .copyWith(
                                                  fontSize: 16,
                                                  color:
                                                      Styles.adaptiveBlueColor),
                                        ),
                                ))),
                      )
                    ],
                  ),
                ),
              ),
              Consumer<BluetoothProvider>(builder: (_, bluetoothProvider, ___) {
                if (bluetoothProvider.bluetoothState ==
                        BluetoothState.POWERED_ON ||
                    bluetoothProvider.bluetoothState ==
                        BluetoothState.UNKNOWN) {
                } else {
                  _connectProvider.widgets = [NoDeviceComponent()];
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => _connectProvider.widgets[index],
                      childCount: _connectProvider.widgets.length),
                );
              })
            ]));
  }
}
