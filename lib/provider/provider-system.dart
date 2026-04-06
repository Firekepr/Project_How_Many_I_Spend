import 'package:flutter/cupertino.dart';
import 'package:how_many_i_spend/database/interfaces/system.dart';

class ProviderSystem extends ChangeNotifier {

  bool _theme = false;
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

  SystemInterface? _system;
  SystemInterface? get system => _system;
  setSystemConfigurations(SystemInterface configurations) {
    _system = configurations;
    notifyListeners();
  }

  String _screenTitle = "Gastos de Hoje";
  String get screenTitle => _screenTitle;
  void setScreenTitle(String title) {
    _screenTitle = title;
    notifyListeners();
  }
}