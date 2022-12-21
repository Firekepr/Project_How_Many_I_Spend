import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:how_many_i_spend/database/database.dart';
import 'package:how_many_i_spend/database/interfaces/calendar-items.dart';
import 'package:how_many_i_spend/provider/provider-calendar.dart';
import 'package:how_many_i_spend/provider/provider-system.dart';
import 'package:how_many_i_spend/widgets/dialogs/calendar-add-dialog.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'global-context.dart';

class CalendarService {
  final DatabaseHelper _db = DatabaseHelper.instance;

  addNewEventModal(BuildContext context, DateTime? selectDate) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return CalendarAddDialog(initialDateTime: selectDate ??  DateTime.now(),);
      },
    );

  }

  Future<void> addNewEvent(Map<String, dynamic> formMap) async {
    CalendarItems item = CalendarItems(
          date: formMap['date'].toString().substring(0, 10),
          type: formMap['type'],
          description: formMap['description'],
          spending: formMap['spending'],
          parcel: formMap['parcel'] ?? '',
          local: formMap['local'] ?? '',
    );

    await _db.insert('mov_calendar_items', item.toMap());
    await updateCalendarEventList();
  }

  Future<void> updateCalendarEventList() async {
    await _updateCalendarItemsProvider();

    ProviderCalendar _provider = getProvider(GlobalContextKey.get()!);
    List<CalendarItems> items = _provider.calendarItems;

    List<DateTime> dates = [];
    if (items.isNotEmpty) {
      for (var event in items) {
        DateTime date = DateTime.parse(event.date);
        if (dates.contains(date) == false) {
          dates.add(date);
        }
      }
    }

    Map<DateTime, List<dynamic>> result = {
      for (var value in dates) value : getDayCalendar(value)
    };

    WidgetsBinding.instance.addPostFrameCallback((_) =>
        getProvider(GlobalContextKey.get()!).setEventListResult(result));
  }

  Future<void> updateCalendarEventListDay() async {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        getProvider(GlobalContextKey.get()!).setCalendarDayListItems(getDayCalendar(DateTime.now())));
  }

  Future<void> _updateCalendarItemsProvider() async {
    String sql = 'Select * from mov_calendar_items';
    List<CalendarItems> returnList = [];

    List<Map<String, dynamic>> response = await _db.getSQLSelect(sql);

    log('Itens listados: ${response.length}');

    if (response.isNotEmpty) {
      for (var element in response) {
        returnList.add(CalendarItems.fromMap(element));
      }
    }

    getProvider(GlobalContextKey.get()!).setCalendarItems(returnList);
  }

  List<CalendarItems> getDayCalendar(DateTime dateParam) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    List<CalendarItems> responseList = [];

    List<CalendarItems> items = getProvider(GlobalContextKey.get()!).calendarItems;

    for (var element in items) {
      if (formatter.format(dateParam) == formatter.format(DateTime.parse(element.date))) {
        responseList.add(element);
      }
    }
    return responseList;
  }

  ProviderCalendar getProvider(BuildContext context) {
    return Provider.of<ProviderCalendar>(context, listen: false);
  }

  updateTheme() {
    ProviderSystem provider = Provider.of<ProviderSystem>(GlobalContextKey.get()!, listen: false);
    provider.setTheme(!provider.theme);
  }
}