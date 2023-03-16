import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:how_many_i_spend/pages/initialize/initialize.dart';
import 'package:how_many_i_spend/provider/provider-system.dart';
import 'package:how_many_i_spend/services/app_theme_service.dart';
import 'package:how_many_i_spend/services/global-context.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderSystem>(
      builder: (BuildContext context, ProviderSystem val, Widget? child) {
        return MaterialApp(
          navigatorKey: GlobalContextKey.navigatorKey,
          title: 'Flutter Demo',

          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            // Locale('en', ''),
            Locale('pt', ''),
          ],

          theme: val.theme ? AppTheme.darkTheme : AppTheme.lightTheme,
          home: const Initialize(),
        );
      },
    );
  }
}