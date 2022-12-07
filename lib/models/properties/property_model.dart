// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/foundation.dart';

import 'package:newavenue/models/agent/agent_model.dart';

class Ad {
  String image;
  int id;
  Ad({
    required this.image,
    required this.id,
  });
  


  factory Ad.fromMap(Map<String, dynamic> map) {
    return Ad(
      image:'http://192.168.1.7:81/'+ map['cover_image'],
      id: map['id'],
    );
  }


}


class FavouriteProperty {
  int id;
  String location;
  String img;
  String price;
  FavouriteProperty({
    required this.id,
    required this.location,
    required this.img,
    required this.price,
  });

  factory FavouriteProperty.fromMap(Map<String, dynamic> map) {
    return FavouriteProperty(
      id: map['id'] as int,
      location: map['location'] as String,
      img:'http://192.168.1.7:81/'+map['images'][0]["image"],
      price: CurrencyFormatter.
      format(int.parse(map['price']  ), 
      CurrencyFormatterSettings(thousandSeparator: ",", symbol: "EGP", 
      symbolSide: SymbolSide.right)).toString(),
    );
  }
}

class AgentProperty {
  int id;
  String img;
  String location;
  String price;
  AgentProperty({
    required this.id,
    required this.img,
    required this.location,
    required this.price,
  });
  factory AgentProperty.fromMap(Map<String, dynamic> map) {
    return AgentProperty(
      id: map['id'] as int,
      img: 'http://192.168.1.7:81/'+map['images'][0]["image"],
      location: map['location'] as String,
      price: CurrencyFormatter.
      format(int.parse(map['price']  ), 
      CurrencyFormatterSettings(thousandSeparator: ",", symbol: "EGP", 
      symbolSide: SymbolSide.right)).toString(),
    );
  }

}

class Property {
  int id;
  Agent agent;
  String name;
  String area;
  String price;
  String saleType;
  String description;
  String location;
  int currentImage;
  bool isFavourite =false;
  List<String> images;
  List details;

  List<String> features;
  Property({
    required this.agent,
    required this.saleType,
    required this.price,
    required this.details,
    required this.features,
    required this.id,
    required this.name,
    required this.area,
    required this.description,
    required this.location,
    required this.currentImage,
    required this.isFavourite,
    required this.images,
  });
  

  


  // Property copyWith({
  //   int? id,
  //   String? name,
  //   int? area,
  //   int? agentId,
  //   String? description,
  //   String? location,
  //   int? currentImage,
  //   bool? isFavourite,
  //   List<String>? images,
  // }) {
  //   return Property(
  //     id: id ?? this.id,
  //     name: name ?? this.name,
  //     area: area ?? this.area,
  //     agentId: agentId ?? this.agentId,
  //     description: description ?? this.description,
  //     location: location ?? this.location,
  //     currentImage: currentImage ?? this.currentImage,
  //     isFavourite: isFavourite ?? this.isFavourite,
  //     images: images ?? this.images,
  //   );
  // }


  factory Property.fromMap(Map<String, dynamic> map) {
    List<String>newImages=[];
    map['images'].forEach((image){
      newImages.add('http://192.168.1.7:81/'+image['image']) ;
    });
    List<String> newFeatures=[];
    map['features'].forEach((feature){
      newFeatures.add(feature['name']) ;
    });
    return Property(
      agent: map["agent"],
      saleType: map["sell_type_id"]==1?"Sale":"Rent",
      // agentAbout: map['agent']['about'],
      // agentName: map['agent']['name'],
      // agentImage: 'http://192.168.1.7:81/'+map['agent']['img'],
      price: CurrencyFormatter.
      format(int.parse(map['price']  ), 
      CurrencyFormatterSettings(thousandSeparator: ",", symbol: "EGP", 
      symbolSide: SymbolSide.right)).toString(),
      details:map["details"] ,
      features: newFeatures,
      id: map['id'] as int,
      name: map['name'] as String,
      area: map['area'] as String,
      // agentId: map['agent_id'] as int,
      description: map['description'] as String,
      location: map['location'] as String,
      // currentImage: map['currentImage'] as int,
      currentImage: 0,
      // isFavourite: map['isFavourite'] as bool,
      isFavourite: false,
    //   images: List<String>.from((map['images'] as List<String>
    //   ),
    // )
    images: newImages
    );
  }



}
