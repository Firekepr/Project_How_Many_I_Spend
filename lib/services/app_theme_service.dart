import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme{
    return ThemeData(
      primaryColor: Colors.black,//Font Color
      secondaryHeaderColor: const Color.fromRGBO(155, 22, 61, 1),
      backgroundColor: Colors.redAccent,
      cardTheme: const CardTheme(
          color: Colors.white
      ),

      fontFamily: 'AlegreyaSans',
      unselectedWidgetColor: Colors.black,
      hoverColor: Colors.grey[100],// input background color
      splashColor: const Color.fromRGBO(220, 159, 178, 1.0), //Color icon bottom bar
      canvasColor: Colors.grey[200],
      cardColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(155, 22, 61, 1),
      ),
      disabledColor: Colors.grey,// Calendar circle border
      focusColor: Colors.transparent,//Focus
      scaffoldBackgroundColor: Colors.white,//Background Color
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color.fromRGBO(209, 36, 113, 1),
      ),
    );
  }
  static ThemeData get darkTheme{
    return ThemeData(
      primaryColor: Colors.white,
      secondaryHeaderColor: Colors.grey[900],
      backgroundColor: Colors.grey[900],
      cardTheme: CardTheme(
        color: Colors.blueGrey[900]
      ),

      fontFamily: 'AlegreyaSans',
      textTheme: const TextTheme(),
      unselectedWidgetColor: Colors.white,
      hoverColor: Colors.blueGrey[900],// input background color
      splashColor: Colors.deepOrange, //Color icon bottom bar
      canvasColor: Colors.blueGrey[700],//List tile ao ser pego
      cardColor: Colors.blueGrey[800],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],),  //App Bar
      disabledColor: Colors.grey, // Calendar circle border color
      focusColor: Colors.transparent,//Focus
      iconTheme: IconThemeData(color: Colors.blueGrey[900]),//Icon Color
      dialogTheme:DialogTheme(
        backgroundColor: Colors.grey[50],),
      scaffoldBackgroundColor: Colors.blueGrey[800], // Background Color
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.black54,
      ),
    );
  }
}