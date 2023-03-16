import 'package:flutter/material.dart';

import '../database/interfaces/calendar-items.dart';

class ProviderCalendar extends ChangeNotifier {

  Map<DateTime, List<dynamic>> _eventList = {};
  Map<DateTime, List<dynamic>>  get calendarEvents => _eventList;
  setEventListResult(Map<DateTime, List<dynamic>> list){
    _eventList = list;
    notifyListeners();
  }

  List<CalendarItems> _items = [];
  List<CalendarItems> get calendarItems => _items;
  setCalendarItems(List<CalendarItems> list) {
    _items = list;
    notifyListeners();
  }

  List<CalendarItems> _dayListItem = [];
  List<CalendarItems> get dayListItem => _dayListItem;
  setCalendarDayListItems(List<CalendarItems> receiveDayListItem) {
    _dayListItem = receiveDayListItem;
    notifyListeners();
  }

}