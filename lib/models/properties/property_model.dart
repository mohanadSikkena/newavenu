// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/foundation.dart';

class Property {
  int id;
  String name;
  String area;
  String price;
  int agentId;
  String description;
  String location;
  int currentImage;
  bool isFavourite =false;
  List<String> images;
  List details;
  String agentName;
  String agentAbout;
  String agentImage;

  List<String> features;
  Property({
    required this.agentAbout,
    required this.agentImage,
    required this.agentName,
    required this.price,
    required this.details,
    required this.features,
    required this.id,
    required this.name,
    required this.area,
    required this.agentId,
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'area': area,
      'agentId': agentId,
      'description': description,
      'location': location,
      'currentImage': currentImage,
      'isFavourite': isFavourite,
      'images': images,
    };
  }

  factory Property.fromMap(Map<String, dynamic> map) {
    List<String>newImages=[];
    map['images'].forEach((image){
      newImages.add('http://localhost:8000/'+image['image']) ;
    });
    List<String> newFeatures=[];
    map['features'].forEach((feature){
      newFeatures.add(feature['name']) ;
    });
    return Property(
      agentAbout: map['agent']['about'],
      agentName: map['agent']['name'],
      agentImage: map['agent']['img']??'s',
      price: CurrencyFormatter.format(int.parse(map['price']  ), CurrencyFormatterSettings(thousandSeparator: ",", symbol: "EGP", symbolSide: SymbolSide.right)).toString(),
      details:map["details"] ,
      features: newFeatures,
      id: map['id'] as int,
      name: map['name'] as String,
      area: map['area'] as String,
      agentId: map['agent_id'] as int,
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

  String toJson() => json.encode(toMap());

  factory Property.fromJson(String source) => Property.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Property(id: $id, name: $name, area: $area, agentId: $agentId, description: $description, location: $location, currentImage: $currentImage, isFavourite: $isFavourite, images: $images)';
  }

  @override
  bool operator ==(covariant Property other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.area == area &&
      other.agentId == agentId &&
      other.description == description &&
      other.location == location &&
      other.currentImage == currentImage &&
      other.isFavourite == isFavourite &&
      listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      area.hashCode ^
      agentId.hashCode ^
      description.hashCode ^
      location.hashCode ^
      currentImage.hashCode ^
      isFavourite.hashCode ^
      images.hashCode;
  }
}
