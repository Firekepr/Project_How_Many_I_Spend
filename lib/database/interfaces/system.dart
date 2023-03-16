
import '../../services/utils-service.dart';

final UtilsService _utils = UtilsService();

class SystemInterface {

  int? id;
  String? first_name;
  String? salary;
  String? user_photo;
  String? password;
  bool dark_theme;
  bool simple_calendar;
  bool show_notification;
  bool first_time;

  SystemInterface({
    this.id,
    this.first_name,
    this.salary,
    this.user_photo,
    this.password,
    required this.dark_theme,
    required this.simple_calendar,
    required this.show_notification,
    required this.first_time,
  });

  factory SystemInterface.fromMap(Map<String, dynamic> map) => SystemInterface(
    id: map['id'],
    first_name: map['first_name'],
    salary: map['salary'],
    user_photo: map['user_photo'],
    password: map['password'],
    dark_theme: mapValue(map, 'dark_theme'),
    simple_calendar: mapValue(map, 'simple_calendar'),
    show_notification: mapValue(map, 'show_notification'),
    first_time: mapValue(map, 'first_time'),
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': first_name,
      'salary': salary,
      'user_photo': user_photo,
      'password': password,
      'dark_theme': dark_theme,
      'simple_calendar': simple_calendar,
      'show_notification': show_notification,
      'first_time': first_time,
    };
  }

  static bool mapValue(Map<String, dynamic> map, String column){
    if (map[column] == '1' || map[column] == 'true' || map[column] == 1){
      return true;
    } else {
      return false;
    }
  }
}