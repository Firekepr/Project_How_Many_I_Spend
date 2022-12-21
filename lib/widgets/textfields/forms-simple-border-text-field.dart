import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:how_many_i_spend/styles/custom-colors.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormBorderTextField extends StatefulWidget {
  final String hintText;
  final bool hideDecoration;
  final bool formatMoney;
  final TextInputType? inputType;
  final String formControlName;
  final String? label;
  final Color? labelColor;
  final double? labelSize;
  final bool? readOnly;
  final EdgeInsetsGeometry? padding;

  const FormBorderTextField({
    Key? key,
    required this.hintText,
    required this.hideDecoration,
    required this.formatMoney,
    required this.formControlName,
    this.inputType,
    this.label,
    this.labelColor,
    this.labelSize,
    this.readOnly,
    this.padding,
  }) : super(key: key);

  @override
  State<FormBorderTextField> createState() => _FormBorderTextFieldState();
}

class _FormBorderTextFieldState extends State<FormBorderTextField> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.only(top: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.label != null
              ? Text(
                widget.label ?? '',
                style: TextStyle(
                    color: widget.labelColor ?? ColorsService.graphiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.labelSize,
                ),
                textAlign: TextAlign.start,
              )
              : Container(),

          Container(
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

              child: ReactiveTextField(
                formControlName: widget.formControlName,
                readOnly: widget.readOnly ?? false,
                keyboardType: widget.inputType ?? TextInputType.text,
                autofocus: false,
                expands: false,
                maxLines: 5,
                minLines: 1,
                style: const TextStyle(color: Colors.black,),
                inputFormatters: widget.formatMoney
                    ? <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        CentavosInputFormatter(moeda: true)
                      ]
                    : null,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorStyle: const TextStyle(height: 0.01, color: Colors.transparent),

                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: widget.hintText,

                  contentPadding: const EdgeInsets.all(12.0),
                  isDense: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
