import 'dart:async';

import 'package:flutter/material.dart';

class InitialConfigurations extends StatefulWidget {
  const InitialConfigurations({Key? key}) : super(key: key);

  @override
  State<InitialConfigurations> createState() => _InitialConfigurationsState();
}

class _InitialConfigurationsState extends State<InitialConfigurations> {
  String visibleMessage = 'Olá!';
  bool _visible = true;
  double opacity = 1.0;

  @override
  void initState() {
    _stepper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _visible
            ? AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(milliseconds: 500),
                child: Text(visibleMessage),
              )
            : Column(
                children: const [
                  Text("Pronto!")
                ],
              ),
      ],
    );
  }

  void _stepper() {
    _fade(1);
    _handleMessage(2, 'Bem vindo ao How many i spend!');
    _fade(3);
    _handleMessage(4, 'Vamos começar?');
    _fade(5);
    Timer(const Duration(seconds: 6), () {
      setState(() {
        _visible = false;
      });
    });
  }

  void _fade(int time) {
    Timer(Duration(seconds: time), () {
      setState(() {
        opacity = opacity == 0.0 ? 1.0 : 0.0;
      });
    });
  }

  void _handleMessage(int time, String message) {
    Timer(Duration(seconds: time), () {
      setState(() {
        opacity = opacity == 0.0 ? 1.0 : 0.0;
        visibleMessage = message;
      });
    });
  }
}
