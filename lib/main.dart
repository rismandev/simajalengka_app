import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:simajalengka_app/common/navigation.dart';
import 'package:simajalengka_app/common/styles.dart';
import 'package:simajalengka_app/ui/article/index.dart';
import 'package:simajalengka_app/ui/main_page.dart';
import 'package:simajalengka_app/ui/splash_page.dart';
import 'package:simajalengka_app/utils/helpers/notification_helper.dart';
import 'package:simajalengka_app/utils/service/background_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simajalengka',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        primaryColorLight: primaryColorLight,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        textTheme: customTextTheme,
        appBarTheme: AppBarTheme(
          textTheme: customTextTheme.apply(bodyColor: Colors.white),
          elevation: 0,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: primaryColor,
          textTheme: ButtonTextTheme.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: Theme.of(context)
              .textTheme
              .caption
              .copyWith(fontWeight: FontWeight.w600),
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: Theme.of(context)
              .textTheme
              .caption
              .copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      initialRoute: SplashPage.routeName,
      navigatorKey: navigatorKey,
      routes: {
        SplashPage.routeName: (context) => SplashPage(),
        MainPage.routeName: (context) => MainPage(),
        ArticleListPage.routeName: (context) => ArticleListPage(),
        ArticleDetailPage.routeName: (context) {
          return ArticleDetailPage(
            article: ModalRoute.of(context).settings.arguments,
          );
        },
        ArticleWebView.routeName: (context) {
          return ArticleWebView(
            url: ModalRoute.of(context).settings.arguments,
          );
        },
      },
    );
  }
}
