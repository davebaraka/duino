import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> pageRoute({Widget page, String animation}) {
  switch (animation) {
    case 'PLATFORM-D': //Default platform animation
      return MaterialPageRoute(builder: (context) => page);
    case 'PLATFORM-F': //Default platform fullscreen animation
      return MaterialPageRoute(
          fullscreenDialog: true, builder: (context) => page);
    case 'FADE':
      return PageTransition(page: page);
    default: //By default, no animation
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;
  PageTransition({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
