import 'dart:io';

import 'package:duino/components/adaptive-components/adaptive-iconbutton.dart';
import 'package:duino/components/adaptive-components/adaptive-navbar.dart';
import 'package:duino/components/adaptive-components/adaptive-scaffold.dart';
import 'package:duino/components/adaptive-components/adaptive-widget.dart';
import 'package:duino/components/state-component.dart';
import 'package:duino/styles.dart';
import 'package:duino/views/remote-view/components/button-component.dart';
import 'package:duino/views/remote-view/providers/remote-provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RemoteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      navBar: AdaptiveNavBar(
        elevation: 0,
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
        backgroundColor: Styles.of(context).barBackgroundColor,
        middle: Text(
          'Remote',
          style: Styles.of(context).navTitleTextStyle,
        ),
        trailing: Padding(
          padding: Platform.isIOS
              ? const EdgeInsets.fromLTRB(0, 0, 16, 0)
              : EdgeInsets.only(),
          child: StateComponent(),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Consumer<RemoteProvider>(
              builder: (_, remoteProvider, __) => AdaptiveWidget(
                    iOS: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: CupertinoSlidingSegmentedControl(
                        children: {
                          0: Text(
                            'Keypad',
                            style: TextStyle(
                                color: Styles.of(context).textStyle.color),
                          ),
                          1: Text('D-pad',
                              style: TextStyle(
                                  color: Styles.of(context).textStyle.color))
                        },
                        onValueChanged: (int value) {
                          remoteProvider.updateGroupValue(value);
                        },
                        groupValue: remoteProvider.groupValue,
                      ),
                    ),
                    android: DefaultTabController(
                      length: 2,
                      child: TabBar(
                        indicatorColor: Styles.of(context).textStyle.color,
                        onTap: (int value) {
                          remoteProvider.updateGroupValue(value);
                        },
                        tabs: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Keypad',
                              style: TextStyle(
                                  color: Styles.of(context).textStyle.color),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('D-pad',
                                style: TextStyle(
                                    color: Styles.of(context).textStyle.color)),
                          )
                        ],
                      ),
                    ),
                  )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ButtonComponent(
                          number: '1',
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        ButtonComponent(
                          number: '2',
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        ButtonComponent(
                          number: '3',
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ButtonComponent(
                          number: '4',
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        ButtonComponent(
                          number: '5',
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        ButtonComponent(
                          number: '6',
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ButtonComponent(
                          number: '7',
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        ButtonComponent(
                          number: '8',
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        ButtonComponent(
                          number: '9',
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ButtonComponent(
                          number: '0',
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
