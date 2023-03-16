import 'package:flutter/material.dart';
import 'package:how_many_i_spend/database/database.dart';
import 'package:how_many_i_spend/global.dart';
import 'package:how_many_i_spend/provider/provider-system.dart';
import 'package:how_many_i_spend/strings/configurations-strings.dart';
import 'package:how_many_i_spend/styles/custom-text-styles.dart';
import 'package:how_many_i_spend/widgets/layout/simple_divisor.dart';
import 'package:how_many_i_spend/widgets/switchs/simple-switch.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../services/utils-service.dart';

class ConfigurationsPage extends StatefulWidget {
  const ConfigurationsPage({Key? key}) : super(key: key);

  @override
  State<ConfigurationsPage> createState() => _ConfigurationsPageState();
}

class _ConfigurationsPageState extends State<ConfigurationsPage> {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final UtilsService _utils = UtilsService();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderSystem>(
      builder: (BuildContext calendarContext, ProviderSystem system, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(ConfigurationString.configurations),
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        ConfigurationString.Theme,
                        style: CustomTextStyles.subTitleStyle2Color(
                            color: Theme.of(context).primaryColor,
                            bold: false,
                        ),
                    ),
                    IconButton(
                      splashColor: Colors.transparent,
                        onPressed: updateTheme,
                        icon: Icon(
                            system.theme
                                ? MdiIcons.whiteBalanceSunny
                                : MdiIcons.weatherNight,
                          color: Theme.of(context).primaryColor,
                        ),
                    )
                  ],
                ),
              ),

              const SimpleDivisor(),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ConfigurationString.calendarStyle(system.simpleCalendar),
                      style: CustomTextStyles.subTitleStyle2Color(
                        color: Theme.of(context).primaryColor,
                        bold: false,
                      ),
                    ),
                    SlideSwitch(
                      value: system.simpleCalendar,
                      onChange: updateCalendar,
                    ),
                  ],
                ),
              ),

              const SimpleDivisor(),
            ],
          ),
        );
      }
    );
  }

  Future<void> updateTheme() async {
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

  Future<void> updateCalendar(bool value) async{
    ProviderSystem provider = Provider.of<ProviderSystem>(context, listen: false);
    provider.setCalendarStyle(!provider.simpleCalendar);

    Map<String, dynamic> toMap = {
      'simple_calendar': _utils.boolToBinary(provider.simpleCalendar),
    };

    await _db.update(
      'mov_user',
      toMap,
      'first_time=?',
      0,
    );
  }
}
