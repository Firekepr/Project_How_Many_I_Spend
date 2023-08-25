import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../styles/custom-colors.dart';

class NumberFormField extends StatelessWidget {
  final String hintText;
  final bool hideDecoration;
  final bool formatMoney;
  final TextInputType? inputType;
  final String formControlName;
  final FormGroup form;
  final String label;
  final Color? labelColor;
  final double? labelSize;
  final bool readOnly;
  final double width;

  const NumberFormField({
    super.key,
    required this.hintText,
    required this.form,
    this.hideDecoration = true,
    this.formatMoney = false,
    required this.formControlName,
    this.inputType,
    this.label = '',
    this.labelColor,
    this.labelSize,
    this.readOnly = false,
    this.width = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: SizedBox(
        width: width != 0.0 ? width : MediaQuery.of(context).size.width * 0.80,
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label.trim().isEmpty
                  ? Container()
                  : Text(
                      label,
                      style: TextStyle(
                        color: labelColor ?? ColorsService.graphiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: labelSize,
                      ),
                      textAlign: TextAlign.start,
                  ),
              Container(
                decoration: hideDecoration
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
                    formControlName: formControlName,
                    readOnly: readOnly,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    expands: false,
                    maxLines: 5,
                    minLines: 1,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    inputFormatters: formatMoney
                        ? <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            CentavosInputFormatter(moeda: true)
                        ] : null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorStyle: const TextStyle(height: 0.01, color: Colors.transparent),
                      hintStyle: const TextStyle(color: Colors.grey),
                      hintText: hintText,
                      contentPadding: const EdgeInsets.all(12.0),
                      isDense: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
