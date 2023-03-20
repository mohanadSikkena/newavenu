// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:currency_formatter/currency_formatter.dart';

import 'package:newavenue/models/agent/agent_model.dart';
import 'package:newavenue/shared/constant.dart';
import 'package:newavenue/shared/network/remote/dio_helper.dart';

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


class ExplorePrimary {
  int id;
  List<String> images;
  int currentImage;
  String minSpace;
  String maxSpace;
  String name;
  String price;
  ExplorePrimary({
    required this.id,
    required this.images,
    required this.currentImage,
    required this.minSpace,
    required this.maxSpace,
    required this.name,
    required this.price,
  });
  

  



  factory ExplorePrimary.fromMap(Map<String, dynamic> map) {
    List<String>newImages=[];
    map['images'].forEach((image){
      newImages.add(DioHelper.url+image['image']) ;
    });

    return ExplorePrimary(
      id: map['id'] as int,
      images: newImages,
      currentImage: 0,
      minSpace: map['min_space'] as String,
      maxSpace: map['max_space'] as String,
      name: map['name'] as String,
      price:  CurrencyFormatter.
      format(map['price'], 
      CurrencyFormatterSettings(thousandSeparator: ",", symbol: "EGP", 
      symbolSide: SymbolSide.right)).toString() 
    );
  }
}

 
class Primary {
  int id;
  int currentImage;
  String name;
  String deliveryDate;
  String paymentPlan;
  String developerName;
  String address;
  String minSpace;
  String maxSpace;
  String price;
  List<String>images;
  String location;
  Primary({
    required this.currentImage,
    required this.images,
    required this.id,
    required this.name,
    required this.deliveryDate,
    required this.paymentPlan,
    required this.developerName,
    required this.address,
    required this.minSpace,
    required this.maxSpace,
    required this.price,
    required this.location,
  });



  

  factory Primary.fromMap(Map<String, dynamic> map) {
    List<String>newImages=[];
    map['images'].forEach((image){
      newImages.add(DioHelper.url+image['image']) ;
    });
    return Primary(
      currentImage: 0,
      images: newImages,
      id: map['id'] as int,
      name: map['name'] as String,
      deliveryDate: map['delivery_date'] as String,
      paymentPlan: map['payment_plan'] as String,
      developerName: map['developer_name'] as String,
      address: map['address'] as String,
      minSpace: map['min_space'] as String,
      maxSpace: map['max_space'] as String,
      price: CurrencyFormatter.
      format(map['price'], 
      CurrencyFormatterSettings(thousandSeparator: ",", symbol: "EGP", 
      symbolSide: SymbolSide.right)).toString() ,
      location: map['location']['name'] as String,
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
  int currentImage;
  bool isFavourite =false;
  List<String> images;
  List details;

  List<String> features;
  Property({
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
      subCategory:Constant.subCategories[map["sub_category_id"]-1]["name"] ,
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
