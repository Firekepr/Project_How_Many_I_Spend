import 'package:flutter/material.dart';
import 'package:how_many_i_spend/provider/provider-system.dart';
import 'package:how_many_i_spend/styles/custom-text-styles.dart';
import 'package:how_many_i_spend/widgets/textfields/number_form_field.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../widgets/textfields/forms-simple-border-text-field.dart';

class SubscribeForm extends StatelessWidget {
  final FormGroup form;
  final int step;
  final Widget Function() buttons;
  final void Function() onChangeTheme;

  const SubscribeForm({
    super.key,
    required this.form,
    required this.step,
    required this.buttons,
    required this.onChangeTheme,
  });

  @override
  Widget build(BuildContext context) {

    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: [
          getBody(context),
          buttons(),
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
          Text("Qual é seu nome ou apelido?", style: style),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: FormBorderTextField(
              formControlName: 'first_name',
              label: '',
              hintText: '',
              hideDecoration: false,
              formatMoney: false,
              padding: EdgeInsets.symmetric(vertical: 10.0),
            ),
          ),
        ],
      );
    } else if (step == 1) {
      return Column(
        children: [
          Text(
            "Para poder lhe ajudar, informe quanto em média você recebe por mês",
            style: style,
            textAlign: TextAlign.center,
          ),
          const FormBorderTextField(
            formControlName: 'salary',
            label: '',
            hintText: 'R\$: 1.000,00',
            hideDecoration: false,
            formatMoney: true,
            padding: EdgeInsets.symmetric(vertical: 10.0),
          ),
          // NumberFormField(
          //   form: form,
          //   formatMoney: true,
          //   hideDecoration: false,
          //   hintText: 'R\$: 1.000,00',
          //   formControlName: 'salary',
          // ),
          Text(
            "(Não se preocupe, esse segredo ficará entre nós dois)",
            style: styleLittle,
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else if (step == 2) {
      return Consumer<ProviderSystem>(builder: (BuildContext calendarContext, ProviderSystem system, Widget? child) {
        return Column(
          children: [
            Text("Selecione um tema:", style: style),
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
