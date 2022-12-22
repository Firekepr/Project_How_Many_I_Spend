import 'package:flutter/material.dart';
import 'package:how_many_i_spend/services/utils-service.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../styles/custom-colors.dart';

class TableCalendarComponent extends StatelessWidget {
  final Map<DateTime, List<dynamic>> events;
  final DateTime daySpotlight;
  final DateTime monthFirstDay;
  final void Function(DateTime selectDay, DateTime focusDay) onDaySelected;
  final void Function(DateTime selectDay, DateTime focusDay) onDayLongPressed;
  final void Function(DateTime firstDay) onChangeMonth;
  final bool minSize;
  final bool isLightTheme;
  final bool simpleCalendar;

  const TableCalendarComponent({
    Key? key,
    required this.events,
    required this.daySpotlight,
    required this.monthFirstDay,
    required this.onDaySelected,
    required this.onChangeMonth,
    required this.onDayLongPressed,
    required this.minSize,
    required this.isLightTheme,
    required this.simpleCalendar,
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

              Color colorDebit = ColorsService.debitColor;
              Color colorCredit = ColorsService.creditColor;
              Color colorMoney = ColorsService.moneyColor;
              Color colorPix = ColorsService.pixColor;

              int debitItem = 0;
              int itemCredit = 0;
              int itemMoney = 0;
              int itemPix = 0;
              int simpleItem = 0;

              for (var element in events) {
                if (simpleCalendar) {
                  simpleItem = 1;
                } else if (element.type == 'Débito' || element.type == 'Debit') {
                  debitItem += 1;
                } else if (element.type == 'Crédito' || element.type == 'Credit') {
                  itemCredit += 1;
                } else if (element.type == 'Dinheiro' || element.type == 'Money') {
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

              if (simpleItem > 0) {
                item.add(simpleItem);
                itemColor.add(Colors.red);
              }
            }

            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: item.length,
              itemExtent: 14.0,
              itemBuilder: (context, index) {
                Color text = Colors.white;

                if(itemColor[index] == Colors.yellow ||
                    itemColor[index] == Colors.blue) {
                  text = Colors.black;
                }

                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 32.0),
                  padding: const EdgeInsets.all(0.5),

                  width: simpleCalendar ? 12 : 15,
                  height: simpleCalendar ? 28 : 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: itemColor[index],
                  ),
                  child: simpleCalendar
                      ? Container()
                      : Text(
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

      //Header like desember and month buttons
      headerStyle: HeaderStyle(
        titleTextStyle: const TextStyle(color: Colors.white),
        titleTextFormatter: (date, locale) => _getHeaderTitle(date, locale),
        headerPadding: const EdgeInsets.only(bottom: 0),


        titleCentered: true,
        formatButtonVisible: true,
        rightChevronVisible: true,
        formatButtonShowsNext: true,

        decoration: BoxDecoration(
          color: isLightTheme
              ? Theme.of(context).cardTheme.color
              : Theme.of(context).backgroundColor,
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

        //=================================================//

        //If false will turn of the today color and cricle
        isTodayHighlighted: true,

        //Today number style / color
        todayTextStyle: TextStyle(color: Theme.of(context).primaryColor),

        //Today circle decoration
        todayDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).primaryColor),
        ),

        //=================================================//


        //=================================================//

        //Selected day number color
        selectedTextStyle: const TextStyle(color: Colors.white),

        //Selected day circle highlight
        selectedDecoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.cyan,
        ),

        //Weekend day number color
        weekendTextStyle: const TextStyle(color: Colors.red),

        //=================================================//

        //Week number style
        defaultTextStyle: TextStyle(color: Theme.of(context).primaryColor),

        //Adjust number padding
        cellPadding: const EdgeInsets.only(top: 0.0),

        //If false will hide previous month days
        outsideDaysVisible: false,

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
