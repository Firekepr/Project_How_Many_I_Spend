class CalendarItems {
  int? id;
  String date;
  String type;
  String description;
  String? parcel;
  String? local;
  String spending;

  CalendarItems({
    this.id,
    required this.date,
    required this.type,
    required this.description,
    this.parcel,
    this.local,
    required this.spending,
  });

  factory CalendarItems.fromMap(Map<String, dynamic> map) => CalendarItems(
        id: map['id'],
        date: map['date'],
        type: map['type'],
        description: map['description'],
        parcel: map['parcel'],
        local: map['local'],
        spending: map['spending'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'type': type,
      'description': description,
      'parcel': parcel,
      'local': local,
      'spending': spending,
    };
  }
}
