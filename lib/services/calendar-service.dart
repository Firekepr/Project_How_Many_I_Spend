import 'package:flutter/material.dart';
import 'package:how_many_i_spend/database/database.dart';
import 'package:how_many_i_spend/widgets/dialogs/calendar-add-dialog.dart';

class CalendarService {

  final DatabaseHelper _db = DatabaseHelper.instance;

  Future<void> getEvents() async {

  }

  Future<void> addEvents() async {

  }

  addNewEventModal(BuildContext context) {

    showDialog(
      context: context,
      // barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return const CalendarAddDialog();
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