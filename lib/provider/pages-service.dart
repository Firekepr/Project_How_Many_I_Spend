import 'package:flutter/material.dart';
import 'package:how_many_i_spend/pages/calendar/calendar.dart';

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