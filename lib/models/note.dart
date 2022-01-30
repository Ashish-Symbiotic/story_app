

import 'dart:convert';
class Notes {
   int? id;
   String title;
   String desc;

  Notes({
    this.id,
    required this.title,
    required this.desc,
  });

  //Convert a Notes into Map. The keys must correspond to the names of the columns
  //in the db.

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'desc': desc};
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      desc: map['desc'] ?? '',
    );
  }

  @override
  String toString() => 'Notes(id :$id,title:$title,desc:$desc)';
}
