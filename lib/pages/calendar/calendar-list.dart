import 'package:flutter/material.dart';

import '../../database/interfaces/calendar-items.dart';
import '../../strings/calendar-strings.dart';
import '../../styles/custom-text-styles.dart';
import 'components/calendar-list-item.dart';

class CalendarList extends StatefulWidget {
  final void Function(CalendarItems scale) onSelectItem;
  final List<CalendarItems> listItems;
  final bool isLightTheme;

  const CalendarList({
    Key? key,
    required this.onSelectItem,
    required this.listItems,
    required this.isLightTheme
  }) : super(key: key);

  @override
  State<CalendarList> createState() => _CalendarListState();
}

class _CalendarListState extends State<CalendarList> {
  Color iconColor = const Color.fromRGBO(14, 189, 154, 1);
  Color titleColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  CalendarStrings.dayPurchase(),
                  style: CustomTextStyles.subTitleStyle2Color(
                      color: Theme.of(context).primaryColor,
                      bold: true
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            itemCount: widget.listItems.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return CalendarListItem(
                item: widget.listItems[index],
                onSelectItem: widget.onSelectItem,
                iconColor: iconColor,
                titleColor: titleColor,
                isLightTheme: widget.isLightTheme,
              );
            },
          )
        ],
      ),
    );
  }
}
