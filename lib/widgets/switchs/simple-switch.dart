import 'package:flutter/material.dart';

class SlideSwitch extends StatelessWidget {
  final String? text;
  final bool value;
  final void Function(bool value) onChange;

  const SlideSwitch({
    Key? key,
    this.text,
    required this.value,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text != null
            ? Text(
            text!,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
            ),
          )
            : Container(),

        Switch(
          value: value,
          onChanged: onChange,
          activeTrackColor: const Color.fromRGBO(155, 22, 61, 1),
          activeColor: Colors.white38,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.black,
        ),
      ],
    );
  }
}
