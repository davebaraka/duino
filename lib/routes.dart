import 'package:duino/components/pageroute-component.dart';
import 'package:duino/views/about-view/about-view.dart';
import 'package:duino/views/connect-vieiw/connect-view.dart';
import 'package:duino/views/connect-vieiw/providers/connect-provider.dart';
import 'package:duino/views/controller-view/controller-view.dart';
import 'package:duino/views/home-view/home-view.dart';
import 'package:duino/views/remote-view/providers/remote-provider.dart';
import 'package:duino/views/remote-view/remote-view.dart';
import 'package:duino/views/tilt-view/tilt-view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic> args = settings.arguments;
    final String animation = settings.isInitialRoute ? null : args['ANIM'];
    final dynamic data = settings.isInitialRoute ? null : args['DATA'];

    switch (settings.name) {
      case '/':
        return pageRoute(page: HomeView(), animation: animation);
      case '/ConnectView':
        return pageRoute(
            page: ChangeNotifierProvider(
                create: (_) => ConnectProvider(), child: ConnectView()),
            animation: animation);
      case '/RemoteView':
        return pageRoute(
            page: ChangeNotifierProvider(
                create: (_) => RemoteProvider(), child: RemoteView()),
            animation: animation);
      case '/ControllerView':
        return pageRoute(page: ControllerView(), animation: animation);
      case '/TiltView':
        return pageRoute(page: TiltView(), animation: animation);
      case '/AboutView':
        return pageRoute(page: AboutView(), animation: animation);
      default:
        return null;
    }
  }
}
