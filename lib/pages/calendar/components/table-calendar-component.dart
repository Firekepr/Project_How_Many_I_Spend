import 'package:flutter/material.dart';
import 'package:how_many_i_spend/services/colors-service.dart';
import 'package:how_many_i_spend/services/utils-service.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarComponent extends StatelessWidget {
  final Map<DateTime, List<dynamic>> events;
  final DateTime daySpotlight;
  final DateTime monthFirstDay;
  final void Function(DateTime selectDay, DateTime focusDay) onDaySelected;
  final void Function(DateTime selectDay, DateTime focusDay) onDayLongPressed;
  final void Function(DateTime firstDay) onChangeMonth;
  final bool minSize;

  const TableCalendarComponent({
    Key? key,
    required this.events,
    required this.daySpotlight,
    required this.monthFirstDay,
    required this.onDaySelected,
    required this.onChangeMonth,
    required this.onDayLongPressed,
    required this.minSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime selectedDay = daySpotlight;
    CalendarFormat format = CalendarFormat.month;

    final Map<CalendarFormat, String> availableCalendarFormats = {
      CalendarFormat.month: 'Mês',
      // CalendarFormat.week: 'Sem',
    };

    return TableCalendar(
      firstDay: monthFirstDay,
      lastDay: DateTime.utc(2099, 10, 20),
      focusedDay: daySpotlight,
      locale: 'pt-Br',
      calendarFormat: format,
      eventLoader: _getEvents,
      availableCalendarFormats: availableCalendarFormats,
      onDaySelected: onDaySelected,
      onPageChanged: onChangeMonth,
      onDayLongPressed: onDayLongPressed,

      //Controls calendar size:
      daysOfWeekHeight: minSize ? 16.0 : 18.0,
      rowHeight: minSize ? 46 : 48,

      selectedDayPredicate: (DateTime date) {
        return isSameDay(selectedDay, date);
      },

      calendarBuilders: CalendarBuilders(
          markerBuilder: (BuildContext context, DateTime date, List<dynamic> events) {
            List<int> item = [];
            List<Color> itemColor = [];

            if (events.isNotEmpty) {
              final UtilsService _utils = UtilsService();

              Color colorDebit = ColorsService.deepRedScale;
              Color colorCredit = Colors.orange;
              Color colorMoney = Colors.green;
              Color colorPix = ColorsService.deepBlueScale;

              int debitItem = 0;
              int itemCredit = 0;
              int itemMoney = 0;
              int itemPix = 0;

              for (var element in events) {
                if (element.type == 'Débito') {
                  debitItem += 1;
                } else if (element.type == 'Crédito') {
                  itemCredit += 1;
                } else if (element.type == 'Dinheiro') {
                  itemMoney += 1;
                }  else {
                  itemPix += 1;
                }
              }

              if (debitItem != 0) {
                item.add(debitItem);
                itemColor.add(colorDebit);
              }

              if (itemCredit > 0) {
                item.add(itemCredit);
                itemColor.add(colorCredit);
              }

              if (itemMoney > 0) {
                item.add(itemMoney);
                itemColor.add(colorMoney);
              }

              if (itemPix > 0) {
                item.add(itemPix);
                itemColor.add(colorPix);
              }
            }

            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: item.length,
              itemBuilder: (context, index) {
                Color text = Colors.white;

                if(itemColor[index] == Colors.yellow ||
                    itemColor[index] == Colors.blue) {
                  text = Colors.black;
                }

                return Container(
                  alignment: Alignment.center,
                  margin:  minSize
                      ? const EdgeInsets.only(top: 28.0)
                      : const EdgeInsets.only(top: 32.0),

                  padding: minSize
                      ? const EdgeInsets.only(bottom: 4)
                      : const EdgeInsets.all(0.5),

                  width: minSize ? 12 : 15,
                  height: minSize ? 28 : 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: itemColor[index],
                  ),
                  child: Text(
                    item[index].toString(),
                    style: TextStyle(color: text, fontSize: 14),
                  ),
                );
              },
            );
          }),

      headerVisible: true,
      pageJumpingEnabled: true,
      pageAnimationEnabled: true,
      daysOfWeekVisible: true,

      headerStyle: HeaderStyle(
        titleTextStyle: const TextStyle(color: Colors.white),
        titleTextFormatter: (date, locale) => _getHeaderTitle(date, locale),
        headerPadding: const EdgeInsets.only(bottom: 0),


        titleCentered: true,
        formatButtonVisible: true,
        rightChevronVisible: true,
        formatButtonShowsNext: true,

        decoration: const BoxDecoration(
          color: Colors.lightGreen,
          // borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(10),
          //     topRight: Radius.circular(10),
          // ),
        ),

        formatButtonTextStyle: const TextStyle(color: Colors.white, fontSize: 16.0),

        headerMargin: const EdgeInsets.only(bottom: 8.0),
        leftChevronIcon: const Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: 28,
        ),
        rightChevronIcon: const Icon(
          Icons.chevron_right,
          color: Colors.white,
          size: 28,
        ),
      ),

      calendarStyle: CalendarStyle(

        weekendTextStyle: const TextStyle(color: Colors.red),
        cellPadding: const EdgeInsets.only(top: 0.0),


        outsideDaysVisible: false,
        isTodayHighlighted: true,

        selectedTextStyle: const TextStyle(color: Colors.white),
        selectedDecoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        ),

        todayTextStyle: const TextStyle(color: Colors.black),
        todayDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black),
        ),
      ),

      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: const TextStyle(color: Colors.red),
        weekendStyle: const TextStyle(color: Colors.blue),
        dowTextFormatter: (date, locale) => _getDayOfWeekText(date, locale),
      ),
    );
  }

  String _getDayOfWeekText(DateTime date, dynamic locale) {
    String day = DateFormat('EEEE', locale).format(date);
    return day[0].toUpperCase();
  }

  String _getHeaderTitle(DateTime date, dynamic locale) {
    String title = DateFormat('MMMM', locale).format(date);
    return title.replaceFirst(RegExp(title[0]), title[0].toUpperCase(), 0);
  }

  List<dynamic> _getEvents(DateTime date) {
    DateTime day = DateTime.parse(date.toString().substring(0, date.toString().length - 14));

    return events[day] ?? [];
  }
}
