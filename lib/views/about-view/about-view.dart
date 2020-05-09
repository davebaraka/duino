import 'package:duino/components/adaptive-components/adaptive-iconbutton.dart';
import 'package:duino/components/adaptive-components/adaptive-navbar.dart';
import 'package:duino/components/adaptive-components/adaptive-scaffold.dart';
import 'package:duino/styles.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
        navBar: AdaptiveNavBar(
          backgroundColor: Styles.of(context).barBackgroundColor,
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
          middle: Text(
            'About',
            style: Styles.of(context).navTitleTextStyle,
          ),
        ),
        child: CustomScrollView(
          cacheExtent: MediaQuery.of(context).size.height,
          physics: AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Guides, tips, suggestions, and contributions',
                      style: Styles.of(context)
                          .textStyle
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.only(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            EvaIcons.githubOutline,
                            color: Styles.adaptiveBlueColor,
                            size: 20,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Github',
                            style: Styles.of(context).textStyle.copyWith(
                                fontSize: 16, color: Styles.adaptiveBlueColor),
                          )
                        ],
                      ),
                      onPressed: () async {
                        const url = 'https://github.com/davebaraka/duino';
                        if (await canLaunch(url)) await launch(url);
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Learn more about the designer and developer',
                      style: Styles.of(context)
                          .textStyle
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.only(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            EvaIcons.atOutline,
                            color: Styles.adaptiveBlueColor,
                            size: 20,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Dev',
                            style: Styles.of(context).textStyle.copyWith(
                                fontSize: 16, color: Styles.adaptiveBlueColor),
                          )
                        ],
                      ),
                      onPressed: () async {
                        const url = 'https://davebaraka.dev';
                        if (await canLaunch(url)) await launch(url);
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Terms and Conditions',
                      style: Styles.of(context)
                          .textStyle
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.only(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            EvaIcons.externalLinkOutline,
                            color: Styles.adaptiveBlueColor,
                            size: 20,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Terms',
                            style: Styles.of(context).textStyle.copyWith(
                                fontSize: 16, color: Styles.adaptiveBlueColor),
                          )
                        ],
                      ),
                      onPressed: () async {
                        const url =
                            'https://github.com/davebaraka/duino/blob/master/TERMS.md';
                        if (await canLaunch(url)) await launch(url);
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Privacy Policy',
                      style: Styles.of(context)
                          .textStyle
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.only(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            EvaIcons.externalLinkOutline,
                            color: Styles.adaptiveBlueColor,
                            size: 20,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Policy',
                            style: Styles.of(context).textStyle.copyWith(
                                fontSize: 16, color: Styles.adaptiveBlueColor),
                          )
                        ],
                      ),
                      onPressed: () async {
                        const url =
                            'https://github.com/davebaraka/duino/blob/master/POLICY.md';
                        if (await canLaunch(url)) await launch(url);
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Attributions',
                      style: Styles.of(context)
                          .textStyle
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Icons made by Eucalyp from flaticon.com',
                            style: Styles.of(context)
                                .textStyle
                                .copyWith(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Version',
                      style: Styles.of(context)
                          .textStyle
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'v0.0.4',
                          style: Styles.of(context)
                              .textStyle
                              .copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
