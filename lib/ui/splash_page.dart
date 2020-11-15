import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simajalengka_app/common/navigation.dart';
import 'package:simajalengka_app/ui/main_page.dart';
import 'package:simajalengka_app/widgets/custom_platform.dart';

class SplashPage extends StatefulWidget {
  static String routeName = 'splash_page';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _goToMainPage();
    super.initState();
  }

  Future _goToMainPage() async {
    await Future.delayed(Duration(seconds: 3), () {
      Navigation.pushAndReplace(MainPage.routeName);
    });
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
      body: _buildPage(),
    );
  }

  CupertinoPageScaffold _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildPage(),
    );
  }

  Widget _buildPage() {
    return Container(
      width: double.infinity,
      color: Color(0xFF002062),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              'assets/icons/icon_app.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
