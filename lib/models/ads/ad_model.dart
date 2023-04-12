import '../../shared/network/remote/dio_helper.dart';

class Ad {
  String image;
  int id;
  
  Ad({
    required this.image,
    required this.id,
  });
  


  factory Ad.fromMap(Map<String, dynamic> map) {
    return Ad(
      image:DioHelper.url+ map['cover_image'],
      id: map['property_id'],
    );
  }


}
