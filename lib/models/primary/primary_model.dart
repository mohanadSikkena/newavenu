


import 'package:currency_formatter/currency_formatter.dart';

import '../../shared/network/remote/dio_helper.dart';

class SimilarPrimary{
  int id;
  String image;
  String minSpace;
  String maxSpace;
  String name;
  String price;

  SimilarPrimary({
    required this.id,
    required this.price,
    required this.minSpace,
    required this.name,
    required this.image,
    required this.maxSpace
});

  factory SimilarPrimary.fromMap(Map<String,dynamic>map){
    return SimilarPrimary(
      image:DioHelper.url+map['images'][0]["image"] ,
      id:map['id'] ,
      maxSpace:map['min_space'] ,
      minSpace: map['max_space'],
      name:map['name'] ,
      price:CurrencyFormatter.
      format(map['min_total_price'],
          CurrencyFormatterSettings(thousandSeparator: ",", symbol: "EGP",
              symbolSide: SymbolSide.right)).toString()  ,
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
      price:  formatCurrency(c:map['min_total_price'] )
    );
  }
}

 
class Primary {
  String name;
  String minSpace;
  String maxSpace;
  String minPricePerMeter;
  String maxPricePerMeter;
  String minTotalPrice;
  String deliveryDate;
  String downPayment;
  String installment;
  String maintenance;
  int id ;
  List<String> images;
  int currentImage;
  String primaryType;
  String location;
  List<SimilarPrimary> similar=[];
  Primary({
    required this.primaryType,
    required this.downPayment,
    required this.installment,
    required this.maintenance,
    required this.maxPricePerMeter,
    required this.minPricePerMeter,
    required this.minTotalPrice,
    required this.location,
    required this.name,
    required this.id,
    required this.images,
    required this.minSpace,
    required this.maxSpace,
    required this.currentImage,
    required this.deliveryDate,
    required this.similar
  });


  factory Primary.fromMap(Map<String, dynamic> map) {
    List<String>newImages=[];
    map['images'].forEach((image){
      newImages.add(DioHelper.url+image['image']) ;


    });

    List<SimilarPrimary>properties=[];
    if(map['similarProperties']!=null){
      map['similarProperties'].forEach((map){
        properties.add(SimilarPrimary.fromMap(map));
      });
    }
    return Primary(
      primaryType:map['primary_type']['name'] as String ,
      downPayment:map['down_payment'] as String , 
      installment: map['min_Installment'] as String, 
      maintenance:map['Maintnance'] as String , 
      maxPricePerMeter: formatCurrency(c: map['min_price']), 
      minPricePerMeter:formatCurrency(c: map['max_price']) , 
      minTotalPrice:formatCurrency(c: map['min_total_price']) ,
      location: map['location']['name'],
      name: map['name'] as String,
      id: map['id'] as int,
      images: newImages,
      minSpace: map['min_space'] as String,
      maxSpace: map['max_space'] as String,
      currentImage:0,
      deliveryDate: map['delivery_date'] as String,
      similar: properties
    );
  }


 
}
String formatCurrency({required String c}){
  return CurrencyFormatter.format(c  , CurrencyFormatterSettings(thousandSeparator: ",", symbol: "EGP", symbolSide: SymbolSide.right)).toString();
}