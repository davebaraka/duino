import 'package:duino/components/adaptive-components/adaptive-button.dart';
import 'package:duino/components/adaptive-components/adaptive-navbar.dart';
import 'package:duino/components/adaptive-components/adaptive-scaffold.dart';
import 'package:duino/styles.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
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
          middle: Text('About'),
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
                          .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    AdaptiveButton(
                      child: Row(
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
                                fontSize: 20, color: Styles.adaptiveBlueColor),
                          )
                        ],
                      ),
                      onPressed: () async {
                        const url = 'https://github.com/davebaraka';
                        if (await canLaunch(url)) await launch(url);
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Learn more about the designer and developer',
                      style: Styles.of(context)
                          .textStyle
                          .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    AdaptiveButton(
                      child: Row(
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
                                fontSize: 20, color: Styles.adaptiveBlueColor),
                          )
                        ],
                      ),
                      onPressed: () async {
                        const url = 'https://davebaraka.dev';
                        if (await canLaunch(url)) await launch(url);
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Privacy Policy',
                      style: Styles.of(context)
                          .textStyle
                          .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    AdaptiveButton(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            EvaIcons.bookOpenOutline,
                            color: Styles.adaptiveBlueColor,
                            size: 20,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Policy',
                            style: Styles.of(context).textStyle.copyWith(
                                fontSize: 20, color: Styles.adaptiveBlueColor),
                          )
                        ],
                      ),
                      onPressed: () async {
                        const url = 'https://davebaraka.dev';
                        if (await canLaunch(url)) await launch(url);
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Attributions',
                      style: Styles.of(context)
                          .textStyle
                          .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Icons made by Eucalyp from flaticon.com',
                      style:
                          Styles.of(context).textStyle.copyWith(fontSize: 20),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Version 0.0.1',
                      style: Styles.of(context)
                          .textStyle
                          .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
