import 'package:flutter/material.dart';

class CustomTextStyles {

  static const TextStyle titleStyle =  TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  static const TextStyle titleStyleWhite =  TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold);

  static const TextStyle listTitleStyle = TextStyle(fontSize: 17, color: Color.fromRGBO(0, 150, 136, 1.0), fontWeight: FontWeight.bold);
  static const TextStyle megaTitleStyle = TextStyle(fontSize: 22, color: Color.fromRGBO(0, 150, 136, 1.0), fontWeight: FontWeight.bold);
  static const TextStyle megaTitleStyleWhite = TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold);
  static const Color red = Colors.red;
  static const Color greyColor = Colors.grey;
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color graphiteColor = Color.fromRGBO(51, 51, 51, 0.8);

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


enum FontSize {
  ///Size: 26.0
  extremeBig,
  ///Size: 20.0
  extraBig,
  ///Size: 20.0
  big,
  ///Size: 18.0
  middleBig,
  ///Size: 16.0
  medium,
  ///Size: 14.00
  small,
  ///Size: 12.00
  extraSmall,
}

enum ColorPallet {
  webDarker,
  web,
  spinLight,
  spinMiddle,
  graphite,
  grey,
  black,
  red,
  white,
}

extension HandleColor on ColorPallet {
  Color color() {
    switch (this) {
      case ColorPallet.graphite:
        return CustomTextStyles.graphiteColor;
      case ColorPallet.black:
        return CustomTextStyles.black;
      case ColorPallet.white:
        return CustomTextStyles.white;
      case ColorPallet.red:
        return CustomTextStyles.red;
      case ColorPallet.grey:
        return CustomTextStyles.greyColor;
      default:
        return CustomTextStyles.black;
    }
  }
}

extension HandleSize on FontSize {
  double size() {
    switch (this) {
      case FontSize.extremeBig:
        return 26.0;
      case FontSize.extraBig:
        return 22.0;
      case FontSize.big:
        return 20.0;
      case FontSize.middleBig:
        return 18.0;
      case FontSize.medium:
        return 16.0;
      case FontSize.small:
        return 14.0;
      case FontSize.extraSmall:
        return 12.0;
      default:
        return 12.0;
    }
  }
}

class CustomFonts {

  ///@Function-Style: user this method to style any text in project.
  ///@Param: FontSize size | @Param ColorPallet color | @Param: bool bold | @Param: bool alert
  static TextStyle custom({
    required FontSize size,
    bool bold = false,
    ColorPallet? color,
    Color? customColor,
    bool alert = false,
    bool normal = false,
    bool highLight = false,
    bool underLine = false,
    double? height,
  }) {
    return TextStyle(
      fontSize: size.size(),
      fontWeight: bold ? FontWeight.bold: FontWeight.normal,
      decoration: underLine ? TextDecoration.underline : null,
      height: height,
      color: color != null
          ? color.color()
          : customColor ?? (highLight
          ? ColorPallet.white.color()
          : alert
          ? CustomTextStyles.red
          : normal
          ? CustomTextStyles.black
          : CustomTextStyles.graphiteColor),

    );
  }
}