import 'dart:core';

class DataBaseTables {

  static const String calendarEvents = ''' 
  CREATE TABLE mov_calendar_itens(
    id integer PRIMARY KEY AUTOINCREMENT,
    date text,
    type text,
    parcel integer DEFAULT 0,
    description text,
    local text,
    spending text
  ) ''';

  static const String currentUser = ''' 
  CREATE TABLE mov_user(
    id integer PRIMARY KEY AUTOINCREMENT,
    salary text DEFAULT '',
    dark_theme integer DEFAULT 0,
    show_notification integer DEFAULT 0,
    auto_complete_parcel integer DEFAULT 0,
    user_photo text DEFAULT ''
  )''';

  static const String systemConfiguration = '''
  CREATE TABLE mov_system(
  id integer PRIMARY KEY AUTOINCREMENT,
  first_time integer DEFAULT 0
  )''';

}