

import 'package:flutter/material.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/property_model.dart';
import 'package:newavenue/modules/properties/property_screen.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';


Widget nearbyWidget(
  {

    required Property property,
    required BuildContext context,
    required Function function
  }
)=>InkWell(
  onTap: (){
    PropertiesCubit.get(context).getProperty( property.id, context);
  },
  child:   Container(
  
    width: 256,
  
    margin: const EdgeInsets.only(right: 15),
  
    child: Column(
  
      crossAxisAlignment: CrossAxisAlignment.start,
  
      children: [
  
        Container(
  
          child: 
  
              Column(
  
  
  
                children: [
  
                  const SizedBox(height: 10,),
  
                  Row(
  
                  crossAxisAlignment: CrossAxisAlignment.start,
  
                  mainAxisAlignment: MainAxisAlignment.end,
  
                    children: [
  
                      IconButton(
                        onPressed: (){
                          function();
                        }, 
                        icon: Icon(
                          property.isFavourite?Icons.favorite:Icons.favorite_border,
                          color: property.isFavourite?favoriteColor:white,),),
  
  
                    ],
  
                  ),
  
                ],
  
              ),
  
           
  
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
  
        Text(property.price,style:f15TextgrayRegular_3 ,)
  
  
  
      ]
  
      ),
  
  ),
);