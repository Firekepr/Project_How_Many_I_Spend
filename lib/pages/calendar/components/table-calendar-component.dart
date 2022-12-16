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

              Color colorWithCheckIn = ColorsService.lightGreenScale;
              Color colorWithoutCheckIn = ColorsService.deepRedScale;
              Color colorWithoutCheckout = ColorsService.lightBlueScale;
              Color colorWithoutConfirm = ColorsService.lightYellowScale;
              Color colorFutureConfirmed = ColorsService.deepBlueScale;

              int scaleComplete = 0;
              int scaleWithoutCheckIn = 0;
              int scaleWithoutCheckout = 0;
              int scaleNeedConfirm = 0;
              int scaleFutureConfirmed = 0;

              for (var element in events) {
                if (_utils.now().isAfter(_utils.transformStringToDateWithoutHourAndNow(element.dt_item))) {
                  if (element.dt_checkin.isEmpty) {
                    scaleWithoutCheckIn += 1;
                  } else if (element.dt_checkout.isEmpty) {
                    scaleWithoutCheckout += 1;
                  } else {
                    scaleComplete += 1;
                  }

                } else if (element.fl_mostrar_botao_confirmar && !element.fl_profissional_aceite) {
                  scaleNeedConfirm += 1;
                } else if (!element.fl_mostrar_botao_confirmar && !element.fl_profissional_aceite
                    ||!element.fl_mostrar_botao_confirmar && element.fl_profissional_aceite
                    || element.fl_mostrar_botao_confirmar && !element.fl_profissional_aceite
                    || element.fl_mostrar_botao_confirmar && element.fl_profissional_aceite){
                  scaleFutureConfirmed += 1;
                } else {
                  scaleComplete += 1;
                }
              }
              if (scaleWithoutCheckIn != 0) {
                item.add(scaleWithoutCheckIn);
                itemColor.add(colorWithoutCheckIn);
              }

              if (scaleWithoutCheckout > 0) {
                item.add(scaleWithoutCheckout);
                itemColor.add(colorWithoutCheckout);
              }

              if (scaleComplete > 0) {
                item.add(scaleComplete);
                itemColor.add(colorWithCheckIn);
              }

              if (scaleNeedConfirm > 0) {
                item.add(scaleNeedConfirm);
                itemColor.add(colorWithoutConfirm);
              }

              if (scaleFutureConfirmed > 0) {
                item.add(scaleFutureConfirmed);
                itemColor.add(colorFutureConfirmed);
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
    DateTime day = DateTime.parse(date.toString().substring(0, date.toString().length - 1));

    return events[day] ?? [];
  }
}
