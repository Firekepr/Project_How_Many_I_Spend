import '../global.dart';

class CalendarStrings {

  //CALENDAR
  static const String emptyList = 'Nenhuma compra relizada';

  static String purchaseBy(String type, String? parcel) {
    if (type == 'Crédito' || type == 'Credit') {
      return 'Feito no $type em $parcel';

    } else {
      return 'Feito no $type';

    }
  }
  static String dayPurchase() {
    if (Global.selectedDay.toString().substring(0, 10) == DateTime.now().toString().substring(0,10)) {
      return 'Compras do dia';
    } else {
      return 'Compras realizadas neste dia:';
    }
  }


  //ADD DIALOG
  static const String amountSpend = 'Valor gasto (obrigatório):';
  static const String cancel = 'Cancelar';
  static const String conclude = 'Concluir';
  static const String newRegister = 'Nova compra';
  static const String selectDate = 'Data:';
  static const String observation = 'Descrição breve:';
  static const String local = 'Local gasto:';
  static const String selectPayment = 'Forma de pagamento:';

}