import 'package:flutter/material.dart';

class ProviderCalendar extends ChangeNotifier {

  Map<DateTime, List<dynamic>> _eventList = {};
  Map<DateTime, List<dynamic>>  get calendarEvents => _eventList;
  setEventListResult(Map<DateTime, List<dynamic>> list){
    _eventList = list;
    notifyListeners();
  }

}