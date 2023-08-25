import 'package:flutter/material.dart';
import 'package:how_many_i_spend/styles/custom-text-styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.inkDrop(
                color: Colors.red,
                size: 50
            ),
            const SizedBox(height: 16),
            Text(
              'Iniciando...',
              style: CustomFonts.custom(
                size: FontSize.middleBig,
                customColor: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
