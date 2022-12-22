import 'package:flutter/material.dart';
import 'package:how_many_i_spend/global.dart';
import 'package:how_many_i_spend/strings/system-strings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';

import '../../../provider/pages-service.dart';
import '../../configurations/configurations.dart';

class AppDrawer extends StatelessWidget {
  final PageController pageController;

  const AppDrawer({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(MdiIcons.cogOutline),
            title: const Text(SystemStrings.configurations),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 600),
                      reverseDuration: const Duration(milliseconds: 600),
                      child: const ConfigurationsPage()));
            },
          ),
        ],
      ),
    );
  }
}

