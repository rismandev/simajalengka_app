import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName, Object arguments) {
    navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  static pushAndReplace(String routeName) {
    navigatorKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
    );
  }

  static back() => navigatorKey.currentState.pop();
}
