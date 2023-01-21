
import 'package:flutter/material.dart';
import 'package:newavenue/models/properties/property_model.dart';
// ignore: unused_import
import 'package:newavenue/modules/properties/property_screen.dart';
import 'package:newavenue/shared/styles/styles.dart';

import '../../models/properties/properties_cubit.dart';



Widget profilePropertyWidget({
  double width=375,
  double height = 812,
  required AgentProperty property,
  required BuildContext context
})=>InkWell(
  excludeFromSemantics: false,
  onTap: (){
    PropertiesCubit.get(context).getProperty(property.id, context);
  },
  child:   Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10)
    ),
  
    width: width*0.4133333333333333,
  
    margin: EdgeInsets.only(right: width*0.0426666666666667),
  
    child: Column(
  
      crossAxisAlignment: CrossAxisAlignment.start,
  
      
  
      children: [
  
        Container(
  
          height: height*0.125615763546798,
  
          decoration: BoxDecoration(
  
            image: DecorationImage(image: NetworkImage(property.img)),
  
            borderRadius: BorderRadius.circular(10)
  
          ),
  
  
  
        ),
  
        Text(property.location,style: f15TextBlackSemibold,maxLines: 2, overflow: TextOverflow.ellipsis),
  
        Text(property.price,style: f15TextgrayRegular_3,)
  
      ],
  
    ),
  
  ),
);