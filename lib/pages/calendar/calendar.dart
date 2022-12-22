import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:how_many_i_spend/pages/calendar/components/table-calendar-component.dart';
import 'package:how_many_i_spend/provider/provider-system.dart';
import 'package:how_many_i_spend/services/calendar-service.dart';
import 'package:how_many_i_spend/provider/provider-calendar.dart';
import 'package:how_many_i_spend/strings/calendar-strings.dart';
import 'package:provider/provider.dart';

import '../../database/database.dart';
import '../../global.dart';
import '../../widgets/layout/simple_divisor.dart';
import 'calendar-list.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final CalendarService _cS = CalendarService();

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProviderCalendar, ProviderSystem>(
        builder: (BuildContext calendarContext, ProviderCalendar values, ProviderSystem system, Widget? child) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // _cS.addNewEventModal(context, null);
            _cS.updateTheme();
            // _cS.updateCalendar();
          },
        ),
        body: Column(
          children: [
            TableCalendarComponent(
              events: values.calendarEvents,
              daySpotlight: Global.scaleMonthSelected,
              monthFirstDay: monthFirstDay(),
              onDaySelected: _onDaySelected,
              onChangeMonth: _onChangeMonth,
              onDayLongPressed: _onLongDayPressed,
              minSize: false,
              isLightTheme: system.theme,
              simpleCalendar: system.simpleCalendar,
            ),

            SimpleDivisor(
                color:Theme.of(context).backgroundColor,
                width: 12,
                topPadding: 4.0,
            ),

            values.dayListItem.isNotEmpty
                ? Expanded(
                  child: SingleChildScrollView(
                    child: CalendarList(
                        listItems: values.dayListItem,
                        isLightTheme: system.theme,
                        onSelectItem: (item) {},
                      ),
                  ),
                )
                : const Padding(
                    padding: EdgeInsets.only(top: 24.0),
                    child: Center(
                      child: Text(
                        CalendarStrings.emptyList,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ],
        ),
      );
    });
  }

  void _onDaySelected(DateTime dayOne, DateTime dayTwo) {
    if (Global.scaleMonthSelected == dayOne) {
      _onLongDayPressed(Global.scaleMonthSelected, dayTwo);
    }

    Global.scaleMonthSelected = dayOne;
    Global.selectedDay = dayOne;
    _updateScaleList(dayOne);
  }

  Future<void> _updateScaleList(DateTime date) async {
    Provider.of<ProviderCalendar>(context, listen: false).setCalendarDayListItems(_cS.getDayCalendar(date));

    setState(() {
      Global.selectedDay = date;
    });
  }

  Future<void> _onChangeMonth(DateTime firstDay) async {}

  DateTime monthFirstDay() {
    DateTime today = DateTime.parse('2019-01-01');

    return today;
  }

  void _onLongDayPressed(DateTime dayOne, DateTime dayTwo) {
    _cS.addNewEventModal(context, dayOne);
  }
}
