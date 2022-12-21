import 'package:flutter/material.dart';

class CustomTextStyles {

  static const TextStyle titleStyle =  TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  static const TextStyle titleStyleWhite =  TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold);

  static const TextStyle listTitleStyle = TextStyle(fontSize: 17, color: Color.fromRGBO(0, 150, 136, 1.0), fontWeight: FontWeight.bold);
  static const TextStyle megaTitleStyle = TextStyle(fontSize: 22, color: Color.fromRGBO(0, 150, 136, 1.0), fontWeight: FontWeight.bold);
  static const TextStyle megaTitleStyleWhite = TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold);

  //Subtitle (Previous Attachment, Draft Modal)
  static TextStyle subTitleStyle1(BuildContext context) {
    return TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor);
  }
  static const TextStyle subTitleStyle1White =  TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold);
  static TextStyle subTitleStyle1Color({required Color color, required bool bold}) {
    return TextStyle(fontSize: 18.0, color: color, fontWeight: bold ? FontWeight.bold: FontWeight.normal);
  }

  static TextStyle subTitleStyle2(BuildContext context) {
    return TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor);
  }
  static const TextStyle subTitleStyle2White =  TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold);
  static TextStyle subTitleStyle2Color({required Color color, required bool bold}) {
    return TextStyle(fontSize: 16.0, color: color, fontWeight: bold ? FontWeight.bold: FontWeight.normal);
  }

  static const TextStyle subTitleStyle3 =  TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);
  static const TextStyle subTitleStyle3White =  TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold);
  static TextStyle subTitleStyle3Color(Color color) {
    return TextStyle(fontSize: 14.0, color: color);
  }

  static const TextStyle subTitleStyle4 =  TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);
  static const TextStyle subTitleStyle4UnBold =  TextStyle(fontSize: 12.0);
  static const TextStyle subTitleStyle4White =  TextStyle(fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.bold);
  static TextStyle subTitleStyle$Color(Color color) {
    return TextStyle(fontSize: 12.0, color: color, fontWeight:  FontWeight.bold);
  }

}