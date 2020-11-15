import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simajalengka_app/common/function.dart';
import 'package:simajalengka_app/data/provider/preferences_provider.dart';
import 'package:simajalengka_app/data/provider/scheduling_provider.dart';
import 'package:simajalengka_app/widgets/custom_dialog.dart';
import 'package:simajalengka_app/widgets/custom_platform.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIOS,
    );
  }

  Scaffold _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Simajalengka',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: launchURL,
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
              child: Image.asset(
                'assets/icons/instagram.png',
                width: 25,
                height: 25,
              ),
            ),
          ),
        ],
      ),
      body: _buildContent(context),
    );
  }

  CupertinoPageScaffold _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Simajalengka',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        transitionBetweenRoutes: false,
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: Text('Tema Gelap'),
                trailing: Switch.adaptive(
                  value: provider.isDarkTheme,
                  onChanged: (bool value) => provider.enableDarkTheme(value),
                ),
              ),
            ),
            Material(
              child: ListTile(
                title: Text('Pemberitahuan'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduling, _) {
                    return Switch.adaptive(
                      value: provider.isDailyNewsActive,
                      onChanged: (bool value) {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          scheduling.scheduledNews(value);
                          provider.enableDailyNews(value);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Text(
                    'Copyright ',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 15),
                  ),
                  Icon(
                    Icons.copyright,
                    size: 18,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    '2020',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 15),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Powered by ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Sunda Technology',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
