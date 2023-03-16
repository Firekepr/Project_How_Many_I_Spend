import 'package:flutter/material.dart';
import 'package:how_many_i_spend/provider/provider-calendar.dart';
import 'package:how_many_i_spend/provider/provider-system.dart';
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
        ChangeNotifierProvider<ProviderSystem>(
          create: (_) => ProviderSystem(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
