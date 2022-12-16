import 'package:flutter/material.dart';
import 'package:how_many_i_spend/services/colors-service.dart';

class SimpleDivisor extends StatelessWidget {
  final Color? color;
  final double? width;

  const SimpleDivisor({
    Key? key,
    this.color,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
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
