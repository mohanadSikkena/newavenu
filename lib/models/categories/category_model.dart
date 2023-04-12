





class Category {
  String name;
  int id;
  int count;
  Category({
    required this.count,
    required this.name,
    required this.id,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      count: map['properties_count'] as int,
      name: map['name'] as String,
      id: map['id'] as int,
    );
  }




}