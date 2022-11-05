
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:newavenue/modules/properties/property_screen.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';



Widget profilePropertyWidget({
  required String name,
  double width=375,
  double height = 812,
  required BuildContext context
})=>InkWell(
  onTap: (){
    // Navigator.push(context, MaterialPageRoute(builder: (_){
    //   // return PropertyScreen();
    // }));
  },
  child:   Container(
  
    width: width*0.4133333333333333,
  
    margin: EdgeInsets.only(right: width*0.0426666666666667),
  
    child: Column(
  
      crossAxisAlignment: CrossAxisAlignment.start,
  
      
  
      children: [
  
        Container(
  
          height: height*0.125615763546798,
  
          decoration: BoxDecoration(
  
            color: gray_1,
  
            borderRadius: BorderRadius.circular(10)
  
          ),
  
  
  
        ),
  
        Text(name,style: f15TextBlackSemibold,maxLines: 2, overflow: TextOverflow.ellipsis),
  
        Text('\$239,746',style: f15TextgrayRegular_3,)
  
      ],
  
    ),
  
  ),
);