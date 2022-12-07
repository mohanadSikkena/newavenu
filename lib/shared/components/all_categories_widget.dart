


import 'package:flutter/material.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';


Widget allCategoriesWidget(
  {
    required String name,
    required String img,
    required Function function
  }
)=>InkWell(
  onTap: (){
    function();
  },
  child:Container(
  
    decoration: BoxDecoration(
  
      border: BorderDirectional(bottom: BorderSide(color: gray_2,width: 1),)
  
      
  
    ),
  
    height:84 ,
  
    margin: const EdgeInsets.only(top:16),
  
    child: Row(
  
      mainAxisAlignment:MainAxisAlignment.spaceBetween,
  
      children: [
  
        Text(name,style:f24DisplayBlackBold,),
  
        Row(
  
          children: [
  
            Container(
              padding: EdgeInsets.only(bottom: 16),
  
              height: 80,
  
              width: 84,
  
              decoration: BoxDecoration(
  
                image: DecorationImage(
  
                  image:NetworkImage(
                    img
                  ),fit: BoxFit.cover ),
  
                
  
                borderRadius: BorderRadius.circular(10)
  
                
  
              ),
  
              
  
            ),
  
            const SizedBox(width: 16)
  
          ],
  
        )
  
      ],
  
    ),
  
  
  
  ),
);