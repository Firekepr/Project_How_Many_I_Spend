import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HandleButton extends StatelessWidget {
  final IconData icon;
  final String payName;
  final Color color;
  final bool isSelected;
  final void Function() onTap;

  const HandleButton({
    Key? key,
    required this.icon,
    required this.payName,
    required this.onTap,
    required this.color,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1,
              color: isSelected ? color : Colors.black),
              borderRadius: const BorderRadius.all(
                  Radius.circular(5.0)),
          ), //
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color),
              Text(payName),
            ],
          ),
        ),
      onTap: onTap,
    );
  }
}
