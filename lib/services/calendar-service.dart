import 'package:flutter/material.dart';
import 'package:how_many_i_spend/database/database.dart';
import 'package:how_many_i_spend/widgets/dialogs/calendar-add-dialog.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CalendarService {

  final DatabaseHelper _db = DatabaseHelper.instance;

  Future<void> getEvents() async {

  }

  Future<void> addEvents() async {

  }

  addNewEventModal(BuildContext context, DateTime? selectDate) {

    showDialog(
      context: context,
      // barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return CalendarAddDialog(initialDateTime: selectDate ??  DateTime.now(),);
      },
    );

  }

  adddNewEventModal(DateTime time, DateTime time2, BuildContext context) {

    showDialog(
      context: context,
      // barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return CalendarAddDialog(
          initialDateTime: time,
        );
      },
    );

  }

  // Future selectDate(BuildContext context) async {
  //   DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2019),
  //       lastDate: DateTime(2020));
  //
  //   print(picked);
  // }
}