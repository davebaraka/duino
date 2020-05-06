import 'dart:io';

import 'package:duino/components/pageroute-component.dart';
import 'package:duino/providers/bluetooth-provider.dart';
import 'package:duino/routes.dart';
import 'package:duino/styles.dart';
import 'package:duino/views/home-view/home-view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BluetoothProvider bluetoothProvider = BluetoothProvider();
  await bluetoothProvider.startBluetooth();
  runApp(ChangeNotifierProvider.value(value: bluetoothProvider, child: App()));
}

class App extends StatelessWidget {
  Widget _buildiOS(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Duino',
      theme: Styles.cupertinoTheme,
      initialRoute: '/HomeView',
      onGenerateInitialRoutes: (String initalRoute) =>
          [pageRoute(page: HomeView(), animation: null)],
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Duino',
      theme: Styles.themeDataLight,
      darkTheme: Styles.themeDataDark,
      initialRoute: '/HomeView',
      onGenerateInitialRoutes: (String initalRoute) =>
          [pageRoute(page: HomeView(), animation: null)],
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS) ? _buildiOS(context) : _buildAndroid(context);
  }
}
