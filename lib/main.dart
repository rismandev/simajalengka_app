import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simajalengka_app/common/navigation.dart';
import 'package:simajalengka_app/data/api/api_article.dart';
import 'package:simajalengka_app/data/db/database_helper.dart';
import 'package:simajalengka_app/data/preferences/preferences_helper.dart';
import 'package:simajalengka_app/data/provider/article_provider.dart';
import 'package:simajalengka_app/data/provider/database_provider.dart';
import 'package:simajalengka_app/data/provider/preferences_provider.dart';
import 'package:simajalengka_app/data/provider/scheduling_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ArticleProvider(apiArticle: ApiArticle()),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DataBaseHelper(),
          ),
        )
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Simajalengka',
            debugShowCheckedModeBanner: false,
            theme: provider.themeData,
            builder: (context, child) {
              return CupertinoTheme(
                data: CupertinoThemeData(
                  brightness:
                      provider.isDarkTheme ? Brightness.dark : Brightness.light,
                ),
                child: Material(
                  child: child,
                ),
              );
            },
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
        },
      ),
    );
  }
}
