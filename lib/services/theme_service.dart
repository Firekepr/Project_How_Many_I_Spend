import 'package:flutter/cupertino.dart';
import 'package:how_many_i_spend/database/database.dart';
import 'package:how_many_i_spend/provider/provider-system.dart';
import 'package:how_many_i_spend/services/utils-service.dart';
import 'package:provider/provider.dart';

class ThemeService {
  final UtilsService _utils = UtilsService();
  final DatabaseHelper _db = DatabaseHelper.instance;

  Future<void> updateTheme(BuildContext context) async {
    ProviderSystem provider = Provider.of<ProviderSystem>(context, listen: false);
    provider.setTheme(!provider.theme);

    Map<String, dynamic> toMap = {
      'dark_theme': _utils.boolToBinary(provider.theme),
    };

    await _db.update(
      'mov_user',
      toMap,
      'first_time=?',
      0,
    );
  }

}