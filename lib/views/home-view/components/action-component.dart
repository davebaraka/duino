import 'package:duino/components/adaptive-components/adaptive-theme.dart';
import 'package:duino/styles.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Individual action.
class ActionComponent extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final VoidCallback onPressed;

  ActionComponent(
      {@required this.title,
      @required this.subtitle,
      @required this.image,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: AdaptiveTheme(
        themeData: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: Card(
          clipBehavior: Clip.antiAlias,
          color: Styles.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: InkWell(
            onTap: onPressed,
            child: Container(
              height: 96,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Image.asset(
                        image,
                        filterQuality: FilterQuality.high,
                        height: 64,
                        width: 64,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: Styles.of(context).textStyle.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(
                            subtitle,
                            style: Styles.of(context)
                                .textStyle
                                .copyWith(fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      EvaIcons.chevronRight,
                      color: Styles.of(context).textStyle.color,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
