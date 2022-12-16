import 'package:flutter/material.dart';
import 'package:how_many_i_spend/widgets/buttons/handle-generic-button.dart';
import 'package:how_many_i_spend/widgets/layout/simple_divisor.dart';
import 'package:how_many_i_spend/widgets/pickers/simple-date-picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../services/colors-service.dart';
import '../../strings/calendar-strings.dart';
import '../textfields/simple-border-text-field.dart';

class CalendarAddDialog extends StatefulWidget {
  final DateTime initialDateTime;

  const CalendarAddDialog({
    Key? key,
    required this.initialDateTime,
  }) : super(key: key);

  @override
  State<CalendarAddDialog> createState() => _CalendarAddDialogState();
}

class _CalendarAddDialogState extends State<CalendarAddDialog> {
  DateTime selectedDate = DateTime.now();
  String type = '';
  String parcel = '1x';
  List<String> parcelList = [];
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    parcelList = List<String>.generate(48, (i) => '${i}x');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(children: [
                  InkWell(
                    child: const Icon(
                      Icons.clear_outlined,
                      color: Colors.white,
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  const Positioned(
                    child: Center(
                      child: Text(
                        CalendarStrings.newRegister,
                        style: ColorsService.titleStyleWhite,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Text(CalendarStrings.selectDate),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SimpleDatePicker(
                        initialDateTime: widget.initialDateTime,
                        onSelectDate: (DateTime date) => _onSelectDay),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Row(
                      children: const [
                        Text(CalendarStrings.selectPayment),
                      ],
                    ),
                  ),
                  GridView.count(
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 8,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 4.0,
                    padding: const EdgeInsets.all(16.0),
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ...drawerList(context),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Text(CalendarStrings.amountSpend),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 1.0,
                        ),
                        // color: Colors.black38,
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: SimpleBorderTexField(
                              controller: descriptionController,
                              addItem: () {},
                              hintText: 'R\$: 00,00',
                              hideDecoration: false,
                              inputType: TextInputType.number,
                              formatMoney: true,
                            ),
                          ),
                          type == 'Crédito'
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: DropdownButton(
                                    items: parcelList.map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                    )).toList(),
                                    value: parcel,
                                    onChanged: _dropDownCallBack,
                                    elevation: 0,
                                    underline: const SizedBox(),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Card(
                      elevation: 1,
                      color: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          // side: const BorderSide(color: Color.fromRGBO(0, 160, 227, 1)),
                      ),
                      child: InkWell(
                        onTap: saveRegister,
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                              CalendarStrings.conclude,
                              style: TextStyle(fontSize: 15, color: Colors.white)
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSelectDay(DateTime selectedDay) {
    setState(() {
      selectedDate = selectedDay;
    });
  }

  void _dropDownCallBack(String? selectedValue) {
    if (selectedValue != null) {
      setState(() {
        parcel = selectedValue;
      });
    }
  }

  List<Map<String, dynamic>> itemsList(BuildContext context) {
    return [
      {
        'icon': MdiIcons.creditCardFast,
        'title': 'Débito',
        'color': Colors.red,
        'onTap': () {
          setState(() {
            type = 'Débito';
          });
        },
      },
      {
        'icon': MdiIcons.creditCardClock,
        'title': 'Crédito',
        'color': Colors.orange,
        'onTap': () {
          setState(() {
            type = 'Crédito';
          });
        },
      },
      {
        'icon': MdiIcons.accountCash,
        'title': 'Dinheiro',
        'color': Colors.green,
        'onTap': () {
          setState(() {
            type = 'Dinheiro';
          });
        },
      },
      {
        'icon': MdiIcons.qrcode,
        'title': 'PIX',
        'color': Colors.black,
        'onTap': () {
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

  Future<void> saveRegister() async {
    Navigator.of(context).pop();
  }
}
