import 'dart:io';

import 'package:duino/components/adaptive-components/adaptive-customscrollview.dart';
import 'package:duino/components/adaptive-components/adaptive-navbar.dart';
import 'package:duino/components/adaptive-components/adaptive-scaffold.dart';
import 'package:duino/components/state-component.dart';
import 'package:duino/styles.dart';
import 'package:duino/views/home-view/components/action-component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The main view listing of all actions.
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      backgroundColor: Styles.of(context).scaffoldBackgroundColor,
      child: AdaptiveCustomScrollView(
          navBar: AdaptiveNavBar(
              backgroundColor: Styles.of(context).barBackgroundColor,
              largeTitle: Text(
                'Duino',
                style: Styles.of(context).navLargeTitleTextStyle,
              ),
              trailing: StateComponent()),
          child: SliverPadding(
            padding: EdgeInsets.only(left: 16, right: 16),
            sliver: SliverList(
                delegate: SliverChildListDelegate.fixed([
              if (Platform.isAndroid)
                SizedBox(
                  height: 16,
                ),
              ActionComponent(
                title: 'Connect',
                subtitle: 'Pair a bluetooth module',
                image: 'assets/bluetooth.png',
                onPressed: () {
                  Navigator.of(context).pushNamed('/ConnectView',
                      arguments: {'ANIM': 'PLATFORM-D', 'DATA': {}});
                },
              ),
              ActionComponent(
                title: 'Remote',
                subtitle: 'Keypad and D-pad',
                image: 'assets/remote.png',
                onPressed: () {
                  Navigator.of(context).pushNamed('/RemoteView',
                      arguments: {'ANIM': 'PLATFORM-D', 'DATA': {}});
                },
              ),
              ActionComponent(
                title: 'Joystick',
                subtitle: 'Virtual joystick',
                image: 'assets/joystick.png',
                onPressed: () {
                  Navigator.of(context).pushNamed('/JoystickView',
                      arguments: {'ANIM': 'PLATFORM-D', 'DATA': {}});
                },
              ),
              ActionComponent(
                title: 'Tilt Pad',
                subtitle: 'Use device sensor',
                image: 'assets/gyroscope.png',
                onPressed: () {
                  Navigator.of(context).pushNamed('/TiltView',
                      arguments: {'ANIM': 'PLATFORM-D', 'DATA': {}});
                },
              ),
              ActionComponent(
                title: 'About',
                subtitle: 'Learn more',
                image: 'assets/about.png',
                onPressed: () {
                  Navigator.of(context).pushNamed('/AboutView',
                      arguments: {'ANIM': 'PLATFORM-D', 'DATA': {}});
                },
              )
            ])),
          )),
    );
  }
}
