import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomFormTextButton extends StatelessWidget {
  final Color? backGroundColor;
  final String label;
  final void Function() onTap;
  final bool isFormButton;

  const CustomFormTextButton({
    Key? key,
    this.backGroundColor,
    required this.label,
    required this.onTap,
    required this.isFormButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return Opacity(
            opacity: !isFormButton
                ? 1
                : isFormButton && form.valid && form.dirty ? 1 : 0.5,
          child: Card(
            elevation: 1,
            color: backGroundColor ?? Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              // side: const BorderSide(color: Color.fromRGBO(0, 160, 227, 1)),
            ),
            child: GestureDetector(
              onTap: !isFormButton
                  ? onTap
                  : isFormButton && form.valid
                  ? onTap
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    )
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
