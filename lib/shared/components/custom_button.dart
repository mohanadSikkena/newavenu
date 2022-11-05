import 'package:flutter/material.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';


Widget customButton(
  {
    double width=120,
    double height =50,
    required String text,
    required Function function
  }
)=>Container(
  height: height,
  width: width,
  decoration: BoxDecoration(
    color: primaryColor,
    borderRadius: BorderRadius.circular(7)
  ),
  child:TextButton(
  
    onPressed: (){
      function();
    }, 
  
    child:Text(text,style: f17TextWhiteRegular,) ),
);