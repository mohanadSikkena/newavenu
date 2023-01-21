

import 'package:flutter/material.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/property_model.dart';

import 'package:newavenue/shared/styles/styles.dart';


Widget nearbyWidget(
  {

    required Property property,
    required BuildContext context,
  }
)=>InkWell(
  onTap: (){
    PropertiesCubit.get(context).getProperty(property.id, context);
    

  },
  child:   Container(
  
    width: 256,
  
    margin: const EdgeInsets.only(right: 15),
  
    child: Column(
  
      crossAxisAlignment: CrossAxisAlignment.start,
  
      children: [
  
        Container(
  
    
  
           
  
          height: 168,
  
          decoration: BoxDecoration(
  
            borderRadius: BorderRadius.circular(15),
  
            image: DecorationImage(image: 
            
  
            NetworkImage(property.images[0]),
            fit: BoxFit.fill
  
            )
  
          ),
  
        ),
  
        Text('${property.area} Sqm',style: f13TextGrayRegular_1,),
  
        Text(property.location, 
        overflow: TextOverflow.ellipsis,
  
  
        style: f15TextBlackSemibold,),
  
        Text(property.price,style:f15TextgrayRegular_3 ,),

        Row(
          children: [
            Text('${property.category}  ',style: f13TextGrayRegular_1,),
            Text(property.subCategory,style: f13TextGrayRegular_1,),
          ],
        )
  
      ]
  
      ),
  
  ),
);