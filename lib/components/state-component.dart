import 'package:duino/components/adaptive-components/adaptive-button.dart';
import 'package:duino/providers/bluetooth-provider.dart';
import 'package:duino/styles.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

class StateComponent extends StatelessWidget {
  void onPressed(context) => Navigator.of(context)
      .pushNamed('/ConnectView', arguments: {'ANIM': 'PLATFORM-D', 'DATA': {}});

  @override
  Widget build(BuildContext context) {
    BluetoothProvider bluetoothProvider =
        Provider.of<BluetoothProvider>(context);
    ConnectionStatus status = bluetoothProvider.status;
    BluetoothState state = bluetoothProvider.bluetoothState;
    if (state != BluetoothState.on) {
      return AdaptiveButton(
        onPressed: () => onPressed(context),
        child: Icon(
          EvaIcons.minusCircleOutline,
          color: Styles.of(context).textStyle.color,
        ),
      );
    } else {
      switch (status) {
        case ConnectionStatus.CONNECTED:
          return AdaptiveButton(
            onPressed: () => onPressed(context),
            child: Icon(
              EvaIcons.checkmarkCircleOutline,
              color: Styles.adaptiveGreenColor,
            ),
          );
        case ConnectionStatus.CONNECTING:
          return AdaptiveButton(
            onPressed: () => onPressed(context),
            child: Icon(
              EvaIcons.activity,
              color: Styles.adaptiveOrangeColor,
            ),
          );
        case ConnectionStatus.DISCONNECTING:
          return AdaptiveButton(
            onPressed: () => onPressed(context),
            child: Icon(
              EvaIcons.activity,
              color: Styles.adaptiveOrangeColor,
            ),
          );
        case ConnectionStatus.ERRORCONNECTING:
          return AdaptiveButton(
            onPressed: () => onPressed(context),
            child: Icon(
              EvaIcons.closeCircleOutline,
              color: Styles.adaptiveRedColor,
            ),
          );
        case ConnectionStatus.ERRORDISCONNECTING:
          return AdaptiveButton(
            onPressed: () => onPressed(context),
            child: Icon(
              EvaIcons.closeCircleOutline,
              color: Styles.adaptiveRedColor,
            ),
          );
        case ConnectionStatus.NONE:
          return AdaptiveButton(
            onPressed: () => onPressed(context),
            child: Icon(
              EvaIcons.minusCircleOutline,
              color: Styles.of(context).textStyle.color,
            ),
          );
        default:
          return null;
      }
    }
  }
}
