import 'package:flutter/material.dart';
import 'package:how_many_i_spend/provider/provider-system.dart';
import 'package:how_many_i_spend/services/global-context.dart';
import 'package:how_many_i_spend/widgets/simple_widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  final Size preferredSize;

  const MyAppBar({super.key}) : preferredSize = const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 24,
      leading: SimpleWidget.customContainer(
        onTap: () => GlobalContextKey.drawerKey.currentState?.openDrawer(),
        padding: const EdgeInsets.only(top: 4.0, left: 4.0),
        child: Icon(
          MdiIcons.dotsVertical,
          size: 32,
          color: Theme.of(context).primaryColor,
        ),
      ),
      centerTitle: true,
      title: Text(
        Provider.of<ProviderSystem>(context).screenTitle,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
