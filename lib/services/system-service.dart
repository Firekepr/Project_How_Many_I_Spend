import 'package:flutter/cupertino.dart';
import 'package:how_many_i_spend/database/database.dart';
import 'package:how_many_i_spend/provider/PHelper.dart';
import 'package:how_many_i_spend/provider/pages-service.dart';
import 'package:page_transition/page_transition.dart';

import '../database/interfaces/system.dart';
import '../pages/home/home.dart';

class SystemService {

  final DatabaseHelper _db = DatabaseHelper.instance;

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

    PHelper.system().setSystemConfigurations(system);
  }

  Future<void> loadSystem(BuildContext context, PageController controller) async {
    String sql = 'Select * from mov_user where first_time = 0';

    List<Map<String, dynamic>> response = await _db.getSQLSelect(sql);

    SystemInterface interface;

    if(response.isNotEmpty) {
      interface = SystemInterface.fromMap(response[0]);

    } else {
      final Brightness brightness = MediaQuery.of(context).platformBrightness;
      final bool isDarkMode = brightness == Brightness.dark;

      interface = SystemInterface(
        dark_theme: isDarkMode,
        first_time: true,
        show_notification: true,
        simple_calendar: true,
        first_name: '',
        password: '',
        salary: '',
        user_photo: '',
      );
    }

    final system = PHelper.system(context: context);

    system.setSystemConfigurations(interface);
    system.setTheme(interface.dark_theme);
    system.setCalendarStyle(interface.simple_calendar);

    if (interface.first_time) {
      controller.jumpToPage(AppInitialPages.initialConfigurations);

    } else {
      Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 600),
            reverseDuration: const Duration(milliseconds: 600),
            child: const Home(),
        ),
      );
    }
  }
}