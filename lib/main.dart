import 'package:flutter/material.dart';
import 'package:how_many_i_spend/services/provider-calendar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'app.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = 'pt_BR';
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderCalendar>(
          create: (_) => ProviderCalendar(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
