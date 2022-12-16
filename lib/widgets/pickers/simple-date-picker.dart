import 'package:flutter/material.dart';
import 'package:how_many_i_spend/services/colors-service.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class SimpleDatePicker extends StatefulWidget {

  final void Function(DateTime dateTime) onSelectDate;

  const SimpleDatePicker({
    Key? key,
    required this.onSelectDate,
  }) : super(key: key);

  @override
  _SimpleDatePickerState createState() => _SimpleDatePickerState();
}

class _SimpleDatePickerState extends State<SimpleDatePicker> {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  DateTime? selectedDate;
  String formattedDate = '';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorsService.graphiteColor,
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            const Icon(
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
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019, 8),
        lastDate: DateTime(2101),
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
