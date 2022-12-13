import 'package:flutter/material.dart';
import 'package:newavenue/models/properties/property_model.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';

import '../../models/properties/properties_cubit.dart';


// ignore: non_constant_identifier_names
Widget SavedWidget(
  {

    required Function function,
    required FavouriteProperty property, 
    required BuildContext context
  }
)=>Container(
  height: 94,
  margin: const EdgeInsets.only(bottom: 14),
  decoration: BoxDecoration(
    color: white,
    border: BorderDirectional(bottom: BorderSide(color: gray_2,width: 0.5))
  ),
  child: InkWell(
    onTap: (){
          PropertiesCubit.get(context).getProperty(property.id, context);

      
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          alignment: Alignment.topRight,
  
          height: 75,
          width: 100,
          decoration: BoxDecoration(
            
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image:NetworkImage(property.img) ,
              fit: BoxFit.fill)
          ),
          child:
              IconButton(
                constraints:const BoxConstraints(),
                padding: EdgeInsets.zero,
                
  
                onPressed: (){
                  function();
                }, 
                icon: Icon(
                 Icons.favorite ,
                  size: 22,
                  color: favoriteColor, )),
                
                
          
  
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text('${property.area} sqm',style: f13TextGrayRegular_1,),
              Text(property.location,
              style: f15TextBlackSemibold,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
              Text(property.price,style: f15TextgrayRegular_3,)
            ],
          ),
        )
      ],
  
    ),
  ),
  

);