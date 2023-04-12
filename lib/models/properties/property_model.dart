// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:currency_formatter/currency_formatter.dart';

import 'package:newavenue/models/agent/agent_model.dart';
import 'package:newavenue/shared/network/remote/dio_helper.dart';



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
      img:DioHelper.url+map['images'][0]["image"],
      price: CurrencyFormatter.
      format(map['price']  , 
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
      img: DioHelper.url+map['images'][0]["image"],
      location: map['location'] as String,
      price: CurrencyFormatter.
      format(map['price']  , 
      CurrencyFormatterSettings(thousandSeparator: ",", symbol: "EGP", 
      symbolSide: SymbolSide.right)).toString(),
    );
  }

}

class Property {
  
  int id;
  Agent agent;
  String subCategory;
  String area;
  String price;
  String saleType;
  String description;
  String location;
  String licence;
  String finish;
  int currentImage;
  bool isFavourite =false;
  List<String> images;
  List details;

  List<String> features;
  Property({
    required this.licence, 
    required this.finish,
    required this.subCategory,
    required this.agent,
    required this.saleType,
    required this.price,
    required this.details,
    required this.features,
    required this.id,
    required this.area,
    required this.description,
    required this.location,
    required this.currentImage,
    required this.isFavourite,
    required this.images,
  });
  factory Property.fromMap(Map<String, dynamic> map) {
    List<String>newImages=[];
    map['images'].forEach((image){
      newImages.add(DioHelper.url+image['image']) ;
    });
    List<String> newFeatures=[];
    map['features'].forEach((feature){
      newFeatures.add(feature['name']) ;
    });
    return Property(
      licence: map['licence']['name'],
      finish: map['finish']['name'],
      subCategory:map["sub_category"]['name'] ,
      agent: map["agent"],
      saleType: map["sell_type_id"]==1?"Sale":"Rent",
      price: CurrencyFormatter.
      format(map['price'], 
      CurrencyFormatterSettings(thousandSeparator: ",", symbol: "EGP", 
      symbolSide: SymbolSide.right)).toString() + (map["sell_type_id"]==2?' P/M':'') ,
      details:map["details"] ,
      features: newFeatures,
      id: map['id'] as int,
      area: map['area'] as String,
      description: map['description'] as String,
      location: map['location'] as String,
      currentImage: 0,
      isFavourite: false,

    images: newImages
    );
  }



}
