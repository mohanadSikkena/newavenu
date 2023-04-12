

class Location {
  String name;
  int id;
  int count;
  Location({
    required this.count,
    required this.name,
    required this.id,
  });

  


  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      count: map['primary_count'] as int,
      name: map['name'] as String,
      id: map['id'] as int,
    );
  }




}
