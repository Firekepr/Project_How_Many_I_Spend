import 'package:flutter/cupertino.dart';

class ProviderSystem extends ChangeNotifier {

  bool _theme = true;
  bool get theme => _theme;
  setTheme(bool handle) {
    _theme = handle;
    notifyListeners();
  }
}