import 'package:flutter/cupertino.dart';
import 'package:how_many_i_spend/database/database.dart';
import 'package:how_many_i_spend/services/utils-service.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../database/interfaces/system.dart';
import '../pages/home/home.dart';
import '../pages/tutorial/new-user.dart';
import '../provider/provider-calendar.dart';
import '../provider/provider-system.dart';
import 'global-context.dart';

class SystemService {

  final DatabaseHelper _db = DatabaseHelper.instance;
  final UtilsService _utils = UtilsService();

  Future<void> addNewSystem(Map<String, dynamic> formMap) async {

    SystemInterface system = SystemInterface(
        first_name: formMap['name'],
        password: '',
        user_photo: '',
        salary: '',
        dark_theme: formMap['theme'],
        simple_calendar: formMap['simple-calendar-type'],
        show_notification: true,
        first_time: false,
    );

    await _db.insert('mov_user', system.toMap());

    getProvider(GlobalContextKey.get()!).setSystemConfigurations(system);
  }

  Future<void> loadSystem(BuildContext context) async {
    String sql = 'Select * from mov_user where first_time = 0';

    List<Map<String, dynamic>> response = await _db.getSQLSelect(sql);

    SystemInterface system;

    if(response.isNotEmpty) {
      system = SystemInterface.fromMap(response[0]);

    } else {
      system = SystemInterface(
        dark_theme: false,
        first_time: true,
        show_notification: true,
        simple_calendar: true,
        first_name: '',
        password: '',
        salary: '',
        user_photo: '',
      );
    }

    getProvider(GlobalContextKey.get()!).setSystemConfigurations(system);
    getProvider(GlobalContextKey.get()!).setTheme(system.dark_theme);
    getProvider(GlobalContextKey.get()!).setCalendarStyle(system.simple_calendar);

    if (system.first_time) {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 600),
              reverseDuration: const Duration(milliseconds: 600),
              child: const InitialPage()));
    } else {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 600),
              reverseDuration: const Duration(milliseconds: 600),
              child: const Home()));
    }

  }

  ProviderSystem getProvider(BuildContext context) {
    return Provider.of<ProviderSystem>(context, listen: false);
  }
}