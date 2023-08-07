import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../styles/custom-colors.dart';


class SimpleDatePicker extends StatefulWidget {

  final void Function(DateTime dateTime) onSelectDate;
  final DateTime initialDateTime;
  final String? label;
  final Color? labelColor;
  final EdgeInsetsGeometry? padding;

  const SimpleDatePicker({
    Key? key,
    required this.onSelectDate,
    required this.initialDateTime,
    this.label,
    this.labelColor,
    this.padding,
  }) : super(key: key);

  @override
  _SimpleDatePickerState createState() => _SimpleDatePickerState();
}

class _SimpleDatePickerState extends State<SimpleDatePicker> {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  DateTime? selectedDate;
  String formattedDate = '';

  @override
  void initState() {
    formattedDate = formatter.format(widget.initialDateTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.only(top: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.label != null
              ? Text(
                widget.label ?? '',
                style: TextStyle(
                    color: widget.labelColor ?? ColorsService.graphiteColor,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.start,
              )
              : Container(),

          InkWell(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(
                  color: Colors.blueGrey,
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    MdiIcons.calendarCursor,
                    color: ColorsService.graphiteColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    formattedDate.isNotEmpty ? formattedDate : 'Data',
                    style: const TextStyle(color: ColorsService.graphiteColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019, 8),
        lastDate: DateTime(2101),
        initialEntryMode: DatePickerEntryMode.calendarOnly
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDate = formatter.format(picked);
        widget.onSelectDate(picked);
      });
    }
  }
}
