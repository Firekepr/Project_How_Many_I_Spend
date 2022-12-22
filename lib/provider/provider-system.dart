import 'package:flutter/cupertino.dart';

class ProviderSystem extends ChangeNotifier {

  bool _theme = true;
  bool get theme => _theme;
  setTheme(bool handle) {
    _theme = handle;
    notifyListeners();
  }

  bool _simpleCalendar = true;
  bool get simpleCalendar => _simpleCalendar;
  setCalendarStyle(bool handle) {
    _simpleCalendar = handle;
    notifyListeners();
  }
}