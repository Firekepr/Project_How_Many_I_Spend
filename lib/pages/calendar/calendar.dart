import 'package:flutter/material.dart';
import 'package:how_many_i_spend/pages/calendar/components/table-calendar-component.dart';
import 'package:how_many_i_spend/services/calendar-service.dart';
import 'package:how_many_i_spend/services/provider-calendar.dart';
import 'package:provider/provider.dart';

import '../../global.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final CalendarService _cS = CalendarService();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderCalendar>(
        builder: (BuildContext calendarContext, ProviderCalendar values, Widget? child) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  _cS.addNewEventModal(context);
                  },
            ),
            body: TableCalendarComponent(
              events: values.calendarEvents,
              daySpotlight: Global.scaleMonthSelected,
              monthFirstDay: monthFirstDay(),
              onDaySelected: _onDaySelected,
              onChangeMonth: _onChangeMonth,
              onDayLongPressed: onLongDayPressed,
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

  void onLongDayPressed(DateTime dayOne, DateTime dayTwo) {
    // _cS.adddNewEventModal(dayOne, dayTwo, context);
    _cS.addNewEventBottomSheet(dayOne, dayTwo, context);
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2020),
    );

    print(picked);
  }
}
