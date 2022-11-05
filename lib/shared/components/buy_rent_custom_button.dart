

import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/styles.dart';
Widget buyRentButton({
  required String text,
  bool selected=false
  })=> 
  Container(
    height: 32,
  decoration:selected? BoxDecoration(
    border: BorderDirectional(
      bottom: BorderSide(
        color: primaryColor,
        
        width: 2
            
      )
    )
  ):null,
 child: 
    Text(
    text,
      style:selected? f17TextBlackSemibold:f17TextGraySemibold_2,));
                    