import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SimpleBorderTexField extends StatefulWidget {
  final Function addItem;
  final TextEditingController controller;
  final String hintText;
  final bool hideDecoration;
  final bool formatMoney;
  final TextInputType? inputType;

  const SimpleBorderTexField({
    Key? key,
    required this.controller,
    required this.addItem,
    required this.hintText,
    required this.hideDecoration,
    required this.formatMoney,
    this.inputType,
  }) : super(key: key);

  @override
  State<SimpleBorderTexField> createState() => _SimpleBorderTexFieldState();
}

class _SimpleBorderTexFieldState extends State<SimpleBorderTexField> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.hideDecoration
          ? null
          : BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              border: Border.all(
                color: Colors.blueGrey,
                width: 1.0,
              ),
          ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextFormField(
          keyboardType: widget.inputType ?? TextInputType.text,
          autofocus: false,
          expands: false,
          maxLines: 5,
          minLines: 1,
          style: const TextStyle(color: Colors.black,),
          inputFormatters: widget.formatMoney
              ? <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      CentavosInputFormatter(moeda: true),
                ]
              : null,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.all(12.0),
            isDense: true,
          ),
          controller: widget.controller,
        ),
      ),
    );
  }
}
