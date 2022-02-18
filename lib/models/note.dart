import 'dart:convert';
class Notes {
   int? id;
   String date;
   String desc;
   String type;

  Notes({
    this.id,
    required this.date,
    required this.desc,
    required this.type,
  });

  //Convert a Notes into Map. The keys must correspond to the names of the columns
  //in the db.

  Map<String, dynamic> toMap() {
    return {'id': id, 'date': date, 'desc': desc,'type': type};
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map['id']?.toInt() ?? 0,
      date: map['date'] ?? '',
      desc: map['desc'] ?? '',
      type: map['type'] ?? '',
    );
  }

  @override
  String toString() => 'Notes(id :$id,date:$date,desc:$desc,type:$type)';
}
