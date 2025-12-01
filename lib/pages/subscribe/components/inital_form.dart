import 'package:flutter/material.dart';
import 'package:how_many_i_spend/provider/provider-system.dart';
import 'package:how_many_i_spend/strings/system-strings.dart';
import 'package:how_many_i_spend/styles/custom-text-styles.dart';
import 'package:how_many_i_spend/widgets/textfields/simple-border-text-field.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class SubscribeForm extends StatelessWidget {
  final int step;
  final Widget buttons;
  final TextEditingController name;
  final TextEditingController salary;
  final void Function() onChangeTheme;
  final void Function() onChange;

  const SubscribeForm({
    super.key,
    required this.step,
    required this.buttons,
    required this.name,
    required this.salary,
    required this.onChangeTheme,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final styleLittle = CustomFonts.custom(size: FontSize.extraSmall, customColor: Theme.of(context).primaryColor);
    final style = CustomFonts.custom(size: FontSize.middleBig, customColor: Theme.of(context).primaryColor);

    return Consumer<ProviderSystem>(builder: (BuildContext calendarContext, ProviderSystem system, Widget? child) {
        return Column(
          children: [
            Text(
                _getText(),
                style: style,
                textAlign: step == 1 ? TextAlign.center : TextAlign.start
            ),

            getBody(context, system),

            if (step == 1) Text(
              SubscribeStrings.stepTwoHint,
              style: styleLittle,
              textAlign: TextAlign.center,
            ) else Container(),

            buttons,
          ],
        );
      }
    );
  }

  Widget getBody(BuildContext context, ProviderSystem system) {
    if (step == 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SimpleBorderTexField(
          controller: name,
          addItem: () {},
          hintText: '',
          hideDecoration: false,
          formatMoney: false,
        ),
      );
    }

    if (step == 1) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SimpleBorderTexField(
          controller: salary,
          addItem: () {},
          hintText: 'R\$: 1.000,00',
          hideDecoration: false,
          formatMoney: true,
        ),
      );
    }

    return IconButton(
      splashColor: Colors.transparent,
      onPressed: onChangeTheme,
      icon: Icon(
        system.theme ? MdiIcons.whiteBalanceSunny : MdiIcons.weatherNight,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  String _getText() {
    if (step == 0) return SubscribeStrings.stepOne;
    if (step == 1) return SubscribeStrings.stepTwo;
    return SubscribeStrings.stepThree;
  }
}
