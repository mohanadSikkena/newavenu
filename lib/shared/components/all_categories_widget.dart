


import 'package:flutter/material.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';


Widget allCategoriesWidget(
  {
    required String name,
    required int len,
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
  
        Column(
  
          crossAxisAlignment: CrossAxisAlignment.start,
  
          children: [
  
            Card(
  
              child: Icon(Icons.house,color: primaryColor ,size: 20,),
  
            ),
  
            Text(name,style:f24DisplayBlackBold,),
  
            Text('$len properties',style:f13TextGrayRegular_1,)
  
  
  
          ],
  
        ),
  
        Row(
  
          children: [
  
            Container(
  
              height: 64,
  
              width: 64,
  
              decoration: BoxDecoration(
  
                image: DecorationImage(
  
                  image:NetworkImage(
                    img
                  ),fit: BoxFit.fill ),
  
                
  
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