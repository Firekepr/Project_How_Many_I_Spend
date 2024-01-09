import 'dart:async';

import 'package:flutter/material.dart';
import 'package:how_many_i_spend/pages/home/home.dart';
import 'package:how_many_i_spend/pages/subscribe/components/inital_form.dart';
import 'package:how_many_i_spend/services/theme_service.dart';
import 'package:how_many_i_spend/strings/system-strings.dart';
import 'package:how_many_i_spend/styles/custom-text-styles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class InitialConfigurations extends StatefulWidget {
  final PageController pageController;

  const InitialConfigurations({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  State<InitialConfigurations> createState() => _InitialConfigurationsState();
}

class _InitialConfigurationsState extends State<InitialConfigurations> {
  final ThemeService _themeS = ThemeService();
  String visibleMessage = 'Olá!';
  bool _visible = true;
  double opacity = 1.0;
  int step = 0;

  final FormGroup _form = FormGroup({
    'first_name': FormControl<String>(value: null, validators: [Validators.required]),
    'salary': FormControl<String>(value: 'a', validators: [Validators.required]),
  });

  @override
  void initState() {
    _stepper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final style = CustomFonts.custom(size: FontSize.middleBig, customColor: Theme.of(context).primaryColor);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _visible
            ? AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(milliseconds: 500),
                child: Text(
                  visibleMessage,
                  textAlign: TextAlign.center,
                  style: style,
                   ),
              )
            : SubscribeForm(
                form: _form,
                step: step,
                buttons: buttons(),
                onChangeTheme: () => _themeS.updateTheme(context),
                onChange: () => setState(() {}),
            )
      ],
    );
  }

  Widget buttons() {
    bool isRequired = step == 0
        ? _form.control('first_name').invalid
        : step == 1
        ? _form.control('salary').invalid
        : false;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(
          opacity: step == 0 ? 0.3 : 1,
          child: IconButton(
            onPressed: step == 0
                ? null
                : () {
                  if(step == 1 && _form.control('salary').value == null) _form.control('salary').value = 'a';

                  setState(() {
                    FocusScope.of(context).requestFocus(FocusNode());
                    step--;
                  });
                },
            icon: Icon(
              MdiIcons.chevronLeft,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),

        Opacity(
          opacity: isRequired ? 0.3 : 1,
          child: IconButton(
            onPressed: isRequired ? null : () {
              if (step >=  2) return _already();
              if (step == 0 && _form.control('salary').value == 'a') _form.control('salary').value = null;

              setState(() {
                FocusScope.of(context).requestFocus(FocusNode());
                step++;
              });
            },

            icon: Icon(
              MdiIcons.chevronRight,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  void _stepper() {
    _fade(1);
    _handleMessage(2, SubscribeStrings.welcome);
    _fade(3);
    _handleMessage(4, SubscribeStrings.begin);
    _fade(5);
    Timer(const Duration(seconds: 6), () => setState(() =>_visible = false));
  }

  void _already() {
    setState(() =>_visible = true);

    _handleMessage(0, SubscribeStrings.already);
    _fade(1);
    _handleMessage(2, SubscribeStrings.remember);
    Timer(const Duration(seconds: 4), () =>
        Navigator.pushReplacement(context,
            MaterialPageRoute(
                builder: (BuildContext context) => const Home(),
            ),
        ),
    );

  }

  void _fade(int time) {
    Timer(Duration(seconds: time), () {
      setState(() {
        opacity = opacity == 0.0 ? 1.0 : 0.0;
      });
    });
  }

  void _handleMessage(int time, String message) {
    Timer(
      Duration(seconds: time), () =>
        setState(() {
          opacity = opacity == 0.0 ? 1.0 : 0.0;
          visibleMessage = message;
        }),
    );
  }
}
