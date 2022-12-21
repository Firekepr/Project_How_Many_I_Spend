import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormDropDown extends StatefulWidget {
  final List<String> items;
  final String formControlName;
  final String hint;
  final String label;
  final double? elevation;
  final bool insideLabel;
  final Color? labelColor;

  const FormDropDown({
    Key? key,
    required this.items,
    required this.formControlName,
    required this.hint,
    required this.label,
    this.elevation,
    required this.insideLabel,
    this.labelColor,
  }) : super(key: key);

  @override
  _FormDropDownState createState() => _FormDropDownState();
}

class _FormDropDownState extends State<FormDropDown> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: 54.0,
        child: ReactiveDropdownField(
          dropdownColor: Colors.grey[200],
          formControlName: widget.formControlName,
          items: widget.items.map((item) {
            return DropdownMenuItem(
              child: Text(item),
              value: item,
            );
          }).toList(),
          decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
