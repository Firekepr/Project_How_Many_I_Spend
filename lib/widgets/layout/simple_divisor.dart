import 'package:flutter/material.dart';

import '../../styles/custom-colors.dart';

class SimpleDivisor extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? topPadding;

  const SimpleDivisor({
    Key? key,
    this.color,
    this.width,
    this.topPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: topPadding ?? 8.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
              color: color ?? ColorsService.graphiteColor,
              width: width ?? 1,
          ),
        ),
      ),
    );
  }
}
