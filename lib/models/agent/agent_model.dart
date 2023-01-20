// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:newavenue/shared/network/remote/dio_helper.dart';

class Agent {
  String name;
  String img;
  String description;
  int id;
  String about;
  Agent({
    required this.name,
    required this.img,
    required this.description,
    required this.id,
    required this.about,
  });




  factory Agent.fromMap(Map<String, dynamic> map) {
    return Agent(
      name: map['name'] as String,
      img: DioHelper.url+map['img'] ,
      description: map['description'] as String,
      id: map['id'] as int,
      about: map['about'] as String,
    );
  }


// agentAbout: map['agent']['about'],
      // agentImage: 'http://192.168.1.7:81/'+map['agent']['img'],


}
