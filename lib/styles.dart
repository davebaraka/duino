import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class Styles {
  /*
  Snackbar colors
  */

  static Color successTextColor = Colors.green[700];
  static Color successBackgroundColor = Colors.green[100];

  static Color dangerTextColor = Colors.red[700];
  static Color dangerBackgroundColor = Colors.red[100];

  static Color warningTextColor = Colors.yellow[700];
  static Color warningBackgroundColor = Colors.yellow[100];

  static Color alertTextColor = Colors.blue[700];
  static Color alertBackgroundColor = Colors.blue[100];

  static Color inactiveTextColor = Colors.grey[700];
  static Color inactiveBackgroundColor = Colors.grey[100];

  /*
  Default Themes
  */

  static ThemeData _themeData = ThemeData();
  static ThemeData _themeDataDark = ThemeData.dark();
  //static CupertinoThemeData _cupertinoThemeData = CupertinoThemeData();

  /*
  Adaptive colors
  */

  // Opaque black color. Used for texts against light backgrounds.
  static Color adaptiveBlackColor =
      Platform.isIOS ? CupertinoColors.black : Colors.black;

  // Opaque white color. Used for backgrounds and fonts against dark backgrounds.
  static Color adaptiveWhiteColor =
      Platform.isIOS ? CupertinoColors.white : Colors.white;

  // Used for iOS 13 for destructive actions such as the delete actions in table view cells and dialogs.
  static Color adaptiveRedColor =
      Platform.isIOS ? CupertinoColors.destructiveRed : Colors.red[700];

  // iOS 13's default green color. Used to indicate active accents such as the switch in its on state and some accent buttons such as the call button and Apple Map's 'Go' button.
  static Color adaptiveGreenColor =
      Platform.isIOS ? CupertinoColors.activeGreen : Colors.green;

  // iOS 13's default blue color. Used to indicate active elements such as buttons, selected tabs and your own chat bubbles.
  static Color adaptiveBlueColor =
      Platform.isIOS ? CupertinoColors.activeBlue : Colors.lightBlue;

  // iOS 13's default blue color. Used to indicate active elements such as buttons, selected tabs and your own chat bubbles.
  static Color adaptiveOrangeColor =
      Platform.isIOS ? CupertinoColors.activeOrange : Colors.orangeAccent;

  // The color for thin borders or divider lines that allows some underlying content to be visible
  static Color adaptiveSeparatorColor = Platform.isIOS
      ? CupertinoColors.opaqueSeparator
      : _themeData.dividerColor;

  // Used in iOS 13 for unselected selectables such as tab bar items in their inactive state or de-emphasized subtitles and details text.
  static Color adaptiveGrayColor =
      Platform.isIOS ? CupertinoColors.inactiveGray : _themeData.disabledColor;

  // The color for placeholder text in controls or text views
  static Color adaptivePlaceholderColor =
      Platform.isIOS ? CupertinoColors.placeholderText : _themeData.hintColor;

  /*
  Platform Themes
  */

  // iOS Dark/Light Theme
  static CupertinoThemeData cupertinoTheme = CupertinoThemeData(
      scaffoldBackgroundColor: CupertinoColors.systemBackground,
      barBackgroundColor: CupertinoColors.systemBackground,
      primaryColor: CupertinoColors.tertiarySystemBackground,
      primaryContrastingColor: CupertinoColors.secondarySystemBackground);

  // Android Light Theme
  static ThemeData themeDataLight = ThemeData(
    textTheme: _themeData.textTheme,
    scaffoldBackgroundColor: Colors.white,
    accentColor: Colors.white,
    primaryColorLight: Colors.white,
    primaryColorDark: Colors.grey[100],
  );

  // Android Dark Theme
  static ThemeData themeDataDark = ThemeData(
    textTheme: _themeDataDark.textTheme,
    scaffoldBackgroundColor: Colors.black,
    accentColor: Colors.black,
    primaryColorLight: Colors.grey[800],
    primaryColorDark: Colors.grey[900],
  );

  // Get Platform Theme Style
  static _Data of(context) => _Data(context: context);
}

class _Data {
  final Color primaryColor;
  final Color primaryContrastingColor;
  final Brightness brightness;
  final Color barBackgroundColor;
  final Color scaffoldBackgroundColor;
  final TextStyle textStyle;
  final TextStyle navTitleTextStyle;
  final TextStyle navLargeTitleTextStyle;

  _Data({context})
      : primaryColor = Platform.isIOS
            ? CupertinoTheme.of(context).primaryColor
            : Theme.of(context).primaryColorLight,
        primaryContrastingColor = Platform.isIOS
            ? CupertinoTheme.of(context).primaryContrastingColor
            : Theme.of(context).primaryColorDark,
        brightness = Platform.isIOS
            ? CupertinoTheme.of(context).brightness
            : Theme.of(context).brightness,
        barBackgroundColor = Platform.isIOS
            ? CupertinoTheme.of(context).barBackgroundColor
            : Theme.of(context).accentColor,
        scaffoldBackgroundColor = Platform.isIOS
            ? CupertinoTheme.of(context).scaffoldBackgroundColor
            : Theme.of(context).scaffoldBackgroundColor,
        textStyle = Platform.isIOS
            ? CupertinoTheme.of(context).textTheme.textStyle
            : Theme.of(context).textTheme.body1,
        navTitleTextStyle = Platform.isIOS
            ? CupertinoTheme.of(context).textTheme.navTitleTextStyle
            : Theme.of(context).textTheme.title,
        navLargeTitleTextStyle =
            Platform.isIOS ? null : Theme.of(context).textTheme.title;
}
