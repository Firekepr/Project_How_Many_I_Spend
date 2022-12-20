import 'package:flutter/material.dart';

class GlobalContextKey {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  static BuildContext? get(){
    return navigatorKey.currentContext;
  }
}