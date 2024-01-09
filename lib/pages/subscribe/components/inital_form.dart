import 'package:flutter/material.dart';
import 'package:how_many_i_spend/provider/provider-system.dart';
import 'package:how_many_i_spend/strings/system-strings.dart';
import 'package:how_many_i_spend/styles/custom-text-styles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../widgets/textfields/forms-simple-border-text-field.dart';

class SubscribeForm extends StatelessWidget {
  final FormGroup form;
  final int step;
  final Widget buttons;
  final void Function() onChangeTheme;
  final void Function() onChange;

  const SubscribeForm({
    super.key,
    required this.form,
    required this.step,
    required this.buttons,
    required this.onChangeTheme,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {

    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: [
          getBody(context),
          buttons,
        ],
      ),
    );
  }

  Widget getBody(BuildContext context) {
    final style = CustomFonts.custom(size: FontSize.middleBig, customColor: Theme.of(context).primaryColor);
    final styleLittle = CustomFonts.custom(size: FontSize.extraSmall, customColor: Theme.of(context).primaryColor);

    if (step == 0) {
      return Column(
        children: [
          Text(SubscribeStrings.stepOne, style: style),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: FormBorderTextField(
              formControlName: 'first_name',
              label: '',
              hintText: '',
              hideDecoration: false,
              formatMoney: false,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              onChange: (value) => onChange(),
            ),
          ),
        ],
      );
    } else if (step == 1) {
      return Column(
        children: [
          Text(
            SubscribeStrings.stepTwo,
            style: style,
            textAlign: TextAlign.center,
          ),
          FormBorderTextField(
            formControlName: 'salary',
            label: '',
            hintText: 'R\$: 1.000,00',
            hideDecoration: false,
            formatMoney: true,
            inputType: TextInputType.number,
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            onChange: (value) => onChange(),
          ),
          Text(
            SubscribeStrings.stepTwoHint,
            style: styleLittle,
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else if (step == 2) {
      return Consumer<ProviderSystem>(builder: (BuildContext calendarContext, ProviderSystem system, Widget? child) {
        return Column(
          children: [
            Text(SubscribeStrings.stepThree, style: style),
            IconButton(
              splashColor: Colors.transparent,
              onPressed: onChangeTheme,
              icon: Icon(
                system.theme ? MdiIcons.whiteBalanceSunny : MdiIcons.weatherNight,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        );
      });
    } else {
      return Container();
    }
  }
}
