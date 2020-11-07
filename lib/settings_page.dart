import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: Text('Tema Gelap'),
            trailing: Switch.adaptive(
              value: false,
              onChanged: (bool value) => customDialog(context),
            ),
          ),
        ),
        Material(
          child: ListTile(
            title: Text('Pemberitahuan'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduling, _) {
                return Switch.adaptive(
                  value: scheduling.isScheduled,
                  onChanged: (bool value) {
                    if (Platform.isIOS) {
                      customDialog(context);
                    } else {
                      scheduling.scheduledNews(value);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
