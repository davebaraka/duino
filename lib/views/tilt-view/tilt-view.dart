import 'package:duino/components/adaptive-components/adaptive-button.dart';
import 'package:duino/components/adaptive-components/adaptive-navbar.dart';
import 'package:duino/components/adaptive-components/adaptive-scaffold.dart';
import 'package:duino/components/state-component.dart';
import 'package:duino/styles.dart';
import 'package:duino/views/tilt-view/components/ring-component.dart';
import 'package:flutter/cupertino.dart';

class TiltView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
        navBar: AdaptiveNavBar(
          leading: AdaptiveButton(
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
          middle: Text('Tilt Pad'),
          trailing: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: StateComponent(),
          ),
        ),
        child: RingComponent());
  }
}
