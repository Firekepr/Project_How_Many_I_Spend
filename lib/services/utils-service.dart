import 'package:intl/intl.dart';

class UtilsService{

  final DateFormat formatterDayHourSQLite = DateFormat('yyyy-MM-dd HH:mm:ss', "pt-Br");
  final DateFormat formatterDayHourPtBr = DateFormat('dd/MM/yyyy HH:mm:ss', "pt-Br");

  DateTime now() {
    return DateTime.now().toLocal();
  }

  DateTime transformStringToDateWithoutHourAndNow(String param) {
    DateFormat formatter = formatterDayHourSQLite;
    if (param.contains("/")) {
      formatter = formatterDayHourPtBr;
    }

    DateFormat formatter2 = DateFormat('HH:mm:ss', "pt-Br");
    return formatter.parse(param + ' ' + formatter2.format(DateTime.now()));
  }

}