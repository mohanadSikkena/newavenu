

import 'package:flutter/material.dart';
import '../styles/colors.dart';
import '../styles/styles.dart';
Widget buyRentButton({
  required String text,
  bool selected=false, 
  required BuildContext context
  })=> 
  Container(
    height: 32,
  decoration:selected? const BoxDecoration(
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
      style:selected? 
      Theme.of(context).textTheme.headlineLarge
      
      :f17TextGraySemibold_2,
      ));
                    