import 'dart:core';

class DataBaseTables {

  static const String calendarEvents = ''' 
  CREATE TABLE mov_calendar_items(
    id integer PRIMARY KEY AUTOINCREMENT,
    date text,
    type text,
    parcel text,
    description text,
    local text,
    spending text
  ) ''';

  static const String systemConfiguration = '''
  CREATE TABLE mov_user(
  id integer PRIMARY KEY AUTOINCREMENT,
  first_name text DEFAULT '',
  salary text DEFAULT '',
  user_photo text DEFAULT '',
  password text DEFAULT '',
  show_notification integer DEFAULT 0,
  dark_theme integer DEFAULT 0,
  simple_calendar integer DEFAULT 0,
  first_time integer DEFAULT 1
  )''';

}