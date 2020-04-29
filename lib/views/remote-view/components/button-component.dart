import 'package:duino/components/adaptive-components/adaptive-material.dart';
import 'package:duino/providers/bluetooth-provider.dart';
import 'package:duino/styles.dart';
import 'package:duino/views/remote-view/providers/remote-provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonComponent extends StatelessWidget {
  final String number;
  ButtonComponent({@required this.number});

  bool isVisible(RemoteProvider remoteProvider, String number) {
    return (remoteProvider.groupValue == 1 &&
            ['2', '4', '6', '8'].contains(number)) ||
        remoteProvider.groupValue == 0;
  }

  IconData buildIcon(number) {
    switch (number) {
      case '2':
        return EvaIcons.chevronUpOutline;
      case '4':
        return EvaIcons.chevronLeftOutline;
      case '6':
        return EvaIcons.chevronRightOutline;
      case '8':
        return EvaIcons.chevronDownOutline;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    BluetoothProvider bluetoothProvider =
        Provider.of<BluetoothProvider>(context, listen: false);
    RemoteProvider remoteProvider = Provider.of<RemoteProvider>(context);
    bool visible = isVisible(remoteProvider, number);
    return AnimatedSwitcher(
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(child: child, scale: animation);
      },
      duration: Duration(milliseconds: 125),
      child: visible
          ? Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Styles.of(context).primaryContrastingColor),
              child: Theme(
                  data: Theme.of(context)
                      .copyWith(splashColor: Colors.transparent),
                  child: ClipOval(
                    child: AdaptiveMaterial(
                      child: InkWell(
                        onHighlightChanged:
                            visible && remoteProvider.groupValue == 1
                                ? (bool focus) {
                                    if (focus) {
                                      String direction = number;
                                      switch (direction) {
                                        case '2':
                                          direction = 'N';
                                          break;
                                        case '4':
                                          direction = 'W';
                                          break;
                                        case '6':
                                          direction = 'E';
                                          break;
                                        case '8':
                                          direction = 'S';
                                          break;

                                        default:
                                          direction = '';
                                          break;
                                      }
                                      bluetoothProvider.write(direction);
                                    } else {
                                      bluetoothProvider.write("#");
                                    }
                                  }
                                : null,
                        onTap: remoteProvider.groupValue == 0
                            ? () {
                                bluetoothProvider.write(number + "#");
                              }
                            : visible ? () {} : null,
                        child: Center(
                          child: AnimatedSwitcher(
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                  child: child, scale: animation);
                            },
                            child: remoteProvider.groupValue == 1
                                ? Icon(
                                    buildIcon(number),
                                    size: 64,
                                    color: Styles.of(context).textStyle.color,
                                  )
                                : Text(number,
                                    style: Styles.of(context)
                                        .textStyle
                                        .copyWith(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                            duration: Duration(milliseconds: 250),
                          ),
                        ),
                      ),
                    ),
                  )),
            )
          : SizedBox(
              width: 72,
              height: 72,
            ),
    );
  }
}
