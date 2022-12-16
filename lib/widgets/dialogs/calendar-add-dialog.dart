import 'package:flutter/material.dart';
import 'package:how_many_i_spend/widgets/buttons/handle-generic-button.dart';
import 'package:how_many_i_spend/widgets/layout/simple_divisor.dart';
import 'package:how_many_i_spend/widgets/pickers/simple-date-picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CalendarAddDialog extends StatefulWidget {
  const CalendarAddDialog({Key? key}) : super(key: key);

  @override
  State<CalendarAddDialog> createState() => _CalendarAddDialogState();
}

class _CalendarAddDialogState extends State<CalendarAddDialog> {
  DateTime selectedDate = DateTime.now();
  String type = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Selecione uma data:'),

            SimpleDatePicker(onSelectDate: (DateTime date) => {
              setState((){
                selectedDate = date;
              }),
            }),

            SimpleDivisor(),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Selecione uma forma de pagamento:'),
            ),

            GridView.count(
              crossAxisSpacing: 12,
              mainAxisSpacing: 8,
              crossAxisCount: 3,
              shrinkWrap: true,
              childAspectRatio: 3.0,
              padding: EdgeInsets.all(16.0),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ...drawerList(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> itemsList(BuildContext context) {
    return [
      {
        'icon': MdiIcons.creditCardFast,
        'title': 'Débito',
        'color': Colors.red,
        'onTap': (){
          setState(() {
            type = 'Débito';
          });
        },
      },
      {
        'icon': MdiIcons.creditCardClock,
        'title': 'Crédito',
        'color': Colors.orange,
        'onTap': (){
          setState(() {
            type = 'Crédito';
          });
        },
      },
      {
        'icon': MdiIcons.accountCash,
        'title': 'Dinheiro',
        'color': Colors.green,
        'onTap': (){
          setState(() {
            type = 'Dinheiro';
          });
        },
      },
      {
        'icon': MdiIcons.qrcode,
        'title': 'PIX',
        'color': Colors.black,
        'onTap': (){
          setState(() {
            type = 'PIX';
          });
        },
      },
    ];
  }

  List<HandleButton> drawerList(BuildContext context) {
    List<HandleButton> returnItems = [];

    itemsList(context).forEach((item) {
      if (item['isFamilyMember'] == true) return;

      HandleButton button = HandleButton(
        payName: item['title'],
        icon: item['icon'],
        onTap: item['onTap'],
        color: item['color'],
        isSelected: type == item['title'],
      );

      returnItems.add(button);
    });

    return returnItems.toList();
  }
}
