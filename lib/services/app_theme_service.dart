import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme{
    return ThemeData(
      primaryColor: Colors.black,//Font Color
      fontFamily: 'AlegreyaSans',
      unselectedWidgetColor: Colors.black,
      hoverColor: Colors.grey[100],// input background color
      splashColor: const Color.fromRGBO(220, 159, 178, 1.0), //Color icon bottom bar
      canvasColor: Colors.grey[200],
      cardColor: Colors.white,
      backgroundColor: Colors.redAccent, //Dismissible Container
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(155, 22, 61, 1),
      ),
      secondaryHeaderColor: const Color.fromRGBO(198, 45, 91, 1), // Buttons Calculator
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
      fontFamily: 'AlegreyaSans',
      unselectedWidgetColor: Colors.white,
      hoverColor: Colors.blueGrey[900],// input background color
      splashColor: Colors.deepOrange, //Color icon bottom bar
      canvasColor: Colors.blueGrey[700],//List tile ao ser pego
      cardColor: Colors.blueGrey[800],
      backgroundColor: Colors.lightBlue,// Dismissible color
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],),  //App Bar
      secondaryHeaderColor: Colors.grey[900], // Buttons Calculator
      disabledColor: Colors.grey, // Calendar circle border color
      focusColor: Colors.transparent,//Focus
      iconTheme: IconThemeData(color: Colors.blueGrey[900]),//Icon Color
      dialogTheme:DialogTheme(
        backgroundColor: Colors.grey[50],),
      primaryColor: Colors.white,// Font Color
      scaffoldBackgroundColor: Colors.blueGrey[800], // Background Color
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.black54,
      ),
    );
  }
}