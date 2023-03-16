import 'package:flutter/material.dart';

class ColorsService {

  static const Color graphiteColor = Color.fromRGBO(51, 51, 51, 0.8);
  static const Color debitColor = Colors.red;
  static const Color creditColor = Colors.orange;
  static const Color moneyColor = Color.fromRGBO(28, 166, 4, 1.0);
  static const Color pixColor = Color.fromRGBO(7, 190, 176, 1.0);

  static Color handleTypeColor(String type) {
    if (type == 'Débito' || type == 'Debit') {
      return debitColor;

    } else if (type == 'Crédito' || type == 'Credit') {
      return creditColor;

    } else if (type == 'Dinheiro' || type == 'Money') {
      return moneyColor;

    } else {
      return pixColor;

    }
  }

}