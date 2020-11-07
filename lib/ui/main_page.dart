import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:simajalengka_app/data/api/api_article.dart';
import 'package:simajalengka_app/data/provider/article_provider.dart';
import 'package:simajalengka_app/data/provider/scheduling_provider.dart';
import 'package:simajalengka_app/settings_page.dart';
import 'package:simajalengka_app/ui/article/index.dart';
import 'package:simajalengka_app/utils/helpers/notification_helper.dart';
import 'package:simajalengka_app/utils/service/background_service.dart';
import 'package:simajalengka_app/widgets/custom_platform.dart';

class MainPage extends StatefulWidget {
  static String routeName = 'article_page';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  int bottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    port.listen((_) async => await _service.someTask());
    _notificationHelper.configureSelectNotificationSubject(
      ArticleDetailPage.routeName,
    );
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIOS,
    );
  }

  Scaffold _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavIndex,
        items: _bottomNavbarItems,
        onTap: (selected) {
          setState(() {
            bottomNavIndex = selected;
          });
        },
      ),
    );
  }

  CupertinoTabScaffold _buildIOS(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: bottomNavIndex,
        items: _bottomNavbarItems,
        onTap: (selected) {
          setState(() {
            bottomNavIndex = selected;
          });
        },
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  List<Widget> _listWidget = [
    ChangeNotifierProvider(
      create: (_) => ArticleProvider(apiArticle: ApiArticle()),
      child: ArticleListPage(),
    ),
    ChangeNotifierProvider(
      create: (_) => SchedulingProvider(),
      child: SettingsPage(),
    ),
  ];

  List<BottomNavigationBarItem> _bottomNavbarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.news : Icons.public),
      label: "Berita",
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: 'Pengaturan',
    ),
  ];
}
