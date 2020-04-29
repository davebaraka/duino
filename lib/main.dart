import 'dart:io';

import 'package:duino/providers/bluetooth-provider.dart';
import 'package:duino/routes.dart';
import 'package:duino/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(App());
  });
}

class App extends StatelessWidget {
  Widget _buildiOS(BuildContext context) {
    return CupertinoApp(
      title: 'Duino',
      theme: Styles.cupertinoTheme,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return MaterialApp(
      title: 'Duino',
      theme: Styles.themeDataLight,
      darkTheme: Styles.themeDataDark,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BluetoothProvider(),
        child: (Platform.isIOS) ? _buildiOS(context) : _buildAndroid(context));
  }
}
