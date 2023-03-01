// ignore_for_file: public_member_api_docs, sort_constructors_first



class Location {
  String name;
  int id;
  Location({
    required this.name,
    required this.id,
  });

  


  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      name: map['name'] as String,
      id: map['id'] as int,
    );
  }




}
