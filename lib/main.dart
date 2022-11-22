import 'package:flutter/material.dart';
import 'package:how_many_i_spend/services/provider-calendar.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'app.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting('pt_BR', null).then((_) =>
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<ProviderCalendar>(
              create: (_) => ProviderCalendar(),
            ),
          ],
          child: const MyApp(),
        ),
      ),
  );
}
