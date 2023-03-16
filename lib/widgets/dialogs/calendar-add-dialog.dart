import 'package:flutter/material.dart';
import 'package:how_many_i_spend/services/calendar-service.dart';
import 'package:how_many_i_spend/widgets/buttons/handle-generic-button.dart';
import 'package:how_many_i_spend/widgets/layout/simple_divisor.dart';
import 'package:how_many_i_spend/widgets/pickers/simple-date-picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../provider/provider-system.dart';
import '../../strings/calendar-strings.dart';
import '../../styles/custom-colors.dart';
import '../buttons/form-simple-text-button.dart';
import '../dropdown/Form-drop-down.dart';
import '../textfields/forms-simple-border-text-field.dart';
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
  List<String> parcelList = [];
  TextEditingController billingPrice = TextEditingController();
  TextEditingController title = TextEditingController();

  final FormGroup _form = FormGroup({
    'description': FormControl<String>(value: ''),
    'local': FormControl<String>(value: ''),
    'date': FormControl<DateTime>(),
    'type': FormControl<String>(value: 'Débito'),
    'spending': FormControl<String>(validators: [Validators.required]),
    'parcel': FormControl<String>(value: '1x'),
  });

  @override
  void initState() {
    parcelList = List<String>.generate(48, (i) => '${i}x');
    _form.control('date').value = widget.initialDateTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderSystem>(
        builder: (BuildContext context, ProviderSystem val, Widget? child) {
          return  Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 8),
            backgroundColor: val.theme ? const Color.fromRGBO(155, 22, 61, 1) : Colors.blueGrey[900],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                            CalendarStrings.newRegister,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: val.theme ? Colors.white : Colors.blueGrey[50],
                          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                        ),
                        child: ReactiveForm(
                          formGroup: _form,
                          child: Column(
                            children: [

                              //Description
                              const FormBorderTextField(
                                formControlName: 'description',
                                label: CalendarStrings.observation,
                                hintText: 'Ex: Compras do mês',
                                hideDecoration: false,
                                formatMoney: false,
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                              ),

                              //Local
                              const FormBorderTextField(
                                formControlName: 'local',
                                label: CalendarStrings.local,
                                hintText: 'Ex: SuperMercado',
                                hideDecoration: false,
                                formatMoney: false,
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                              ),

                              //Register Date
                              SimpleDatePicker(
                                label: CalendarStrings.selectDate,
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                initialDateTime: widget.initialDateTime,
                                onSelectDate: (DateTime date) => _form.control('date').value = date,
                              ),

                              //Billing type
                              widgetTitles(CalendarStrings.selectPayment),
                              GridView.count(
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 8,
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                childAspectRatio: 4.0,
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  ...drawerList(context),
                                ],
                              ),

                              //Prices
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  children: [
                                    widgetTitles(CalendarStrings.amountSpend),
                                    Container(
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
                                          const Flexible(
                                            child: FormBorderTextField(
                                              formControlName: 'spending',
                                              hintText: 'R\$: 00,00',
                                              hideDecoration: true,
                                              inputType: TextInputType.number,
                                              formatMoney: true,
                                            ),
                                          ),
                                          _form.control('type').value == "Crédito"
                                              ? Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: FormDropDown(
                                              items: parcelList,
                                              formControlName: 'parcel',
                                              label: '',
                                              insideLabel: false,
                                              hint: '',
                                            ),
                                          )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ReactiveForm(
                      formGroup: _form,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          CustomFormTextButton(
                            label: CalendarStrings.cancel,
                            onTap: () => Navigator.of(context).pop(),
                            isFormButton: false,
                            backGroundColor: Colors.red,
                          ),

                          CustomFormTextButton(
                            label: CalendarStrings.conclude,
                            onTap: saveRegister,
                            isFormButton: true,
                            backGroundColor: null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  Widget widgetTitles(String description) => Padding(
    padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
    child: Row(
      children: [
        Text(description,
            style: const TextStyle(fontWeight: FontWeight.bold, color: ColorsService.graphiteColor)),
      ],
    ),
  );

  Future<void> saveRegister() async {
    final CalendarService service = CalendarService();

    if (_form.control('description').value == '') {
      _form.control('description').value = 'Compras';
    }

    if (_form.control('local').value == '') {
      _form.control('local').value = 'Não informado';
    }

    await service.addNewEvent(_form.value);

    Navigator.of(context).pop();
  }

  List<Map<String, dynamic>> itemsList(BuildContext context) {
    return [
      {
        'icon': MdiIcons.creditCardFast,
        'title': 'Débito',
        'color': ColorsService.debitColor,
      },
      {
        'icon': MdiIcons.creditCardClock,
        'title': 'Crédito',
        'color': ColorsService.creditColor,
      },
      {
        'icon': MdiIcons.accountCash,
        'title': 'Dinheiro',
        'color': ColorsService.moneyColor,
      },
      {
        'icon': MdiIcons.qrcode,
        'title': 'PIX',
        'color': ColorsService.pixColor,
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
        color: item['color'],
        isSelected: _form.control('type').value == item['title'],
        onTap: () {
          _handleType(item['title']);
        },
      );

      returnItems.add(button);
    });

    return returnItems.toList();
  }

  void _handleType(String type) {
    setState(() {
      _form.control('type').value = type;
    });

    if (_form.control('parcel').value != "1x") {
      _form.control('parcel').value = "1x";
    }
  }
}
