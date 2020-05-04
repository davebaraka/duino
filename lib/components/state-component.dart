import 'package:duino/components/adaptive-components/adaptive-iconbutton.dart';
import 'package:duino/providers/bluetooth-provider.dart';
import 'package:duino/styles.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:provider/provider.dart';

/// Icon displays current bluetooth/device state.
class StateComponent extends StatelessWidget {
  void onPressed(context) => Navigator.of(context)
      .pushNamed('/ConnectView', arguments: {'ANIM': 'PLATFORM-D', 'DATA': {}});

  @override
  Widget build(BuildContext context) {
    BluetoothProvider bluetoothProvider =
        Provider.of<BluetoothProvider>(context);
    PeripheralConnectionState deviceState = bluetoothProvider.bleDeviceState;
    BluetoothState bluetoothState = bluetoothProvider.bluetoothState;
    if (bluetoothState == BluetoothState.POWERED_ON || bluetoothState == BluetoothState.UNKNOWN) {
      switch (deviceState) {
        case PeripheralConnectionState.connected:
          return AdaptiveIconButton(
            onPressed: () => onPressed(context),
            child: Icon(
              EvaIcons.checkmarkCircleOutline,
              color: Styles.adaptiveGreenColor,
            ),
          );
        case PeripheralConnectionState.connecting:
          return AdaptiveIconButton(
            onPressed: () => onPressed(context),
            child: Icon(
              EvaIcons.activity,
              color: Styles.adaptiveOrangeColor,
            ),
          );
        case PeripheralConnectionState.disconnecting:
          return AdaptiveIconButton(
            onPressed: () => onPressed(context),
            child: Icon(
              EvaIcons.activity,
              color: Styles.adaptiveOrangeColor,
            ),
          );
        case PeripheralConnectionState.disconnected:
          return AdaptiveIconButton(
            onPressed: () => onPressed(context),
            child: Icon(
              EvaIcons.minusCircleOutline,
              color: Styles.of(context).textStyle.color,
            ),
          );
        default:
      return AdaptiveIconButton(
        onPressed: () => onPressed(context),
        child: Icon(
          EvaIcons.minusCircleOutline,
          color: Styles.of(context).textStyle.color,
        ),
      );
      }
    } else {
      return AdaptiveIconButton(
        onPressed: () => onPressed(context),
        child: Icon(
          EvaIcons.minusCircleOutline,
          color: Styles.of(context).textStyle.color,
        ),
      );
    }
  }
}
