import 'package:flutter/material.dart';
import 'package:how_many_i_spend/pages/calendar.dart';

List<Widget> getPages(PageController pageController, void Function() goBack) {
  return [
    const Calendar(),
  ];
}