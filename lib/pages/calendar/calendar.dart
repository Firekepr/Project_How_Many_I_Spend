import 'package:flutter/material.dart';
import 'package:how_many_i_spend/pages/calendar/components/table-calendar-component.dart';
import 'package:how_many_i_spend/services/provider-calendar.dart';
import 'package:provider/provider.dart';

import '../../global.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderCalendar>(
        builder: (BuildContext calendarContext, ProviderCalendar values, Widget? child) {
          return Scaffold(
            body: TableCalendarComponent(
              events: values.calendarEvents,
              daySpotlight: Global.scaleMonthSelected,
              monthFirstDay: monthFirstDay(),
              onDaySelected: _onDaySelected,
              onChangeMonth: _onChangeMonth,
              minSize: false,
            ),
          );
        }
    );
  }

  void _onDaySelected(DateTime dayOne, DateTime dayTwo) {
    Global.scaleMonthSelected = dayOne;
    Global.selectedDay = dayOne;
    _updateScaleList(dayOne);
  }

  Future<void> _updateScaleList(DateTime date) async {
    // List<Scale> scales = _calendarService.getDayScales(date);
    //
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   Provider.of<ProviderCalendar>(context, listen: false).setScaleListByDay(scales);
    // });

    setState(() {
      Global.selectedDay = date;
    });
  }

  Future<void> _onChangeMonth(DateTime firstDay) async {}

  DateTime monthFirstDay() {
    DateTime today = DateTime.parse('2019-01-01');

    return today;
  }
}
