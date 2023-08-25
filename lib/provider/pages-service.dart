import 'package:flutter/material.dart';
import 'package:how_many_i_spend/pages/calendar/calendar.dart';
import 'package:how_many_i_spend/pages/subscribe/initial_configurations.dart';
import 'package:how_many_i_spend/pages/initialize/loading.dart';

import '../pages/configurations/configurations.dart';

List<Widget> getPages(PageController pageController, void Function() goBack) {
  return [
    const Calendar(),
    const ConfigurationsPage(),
  ];
}

abstract class AppPages {
  static const int calendar = 0;
  static const int configurations = 1;
}

List<Widget> getInitialPages(PageController pageController, void Function() goBack) {
  return [
    const LoadingScreen(),
    InitialConfigurations(pageController: pageController),
  ];
}

abstract class AppInitialPages {
  static const int loading = 0;
  static const int initialConfigurations = 1;
}