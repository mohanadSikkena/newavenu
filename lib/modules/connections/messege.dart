

import 'package:flutter/material.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';

Widget messegeWidget(
  {
    required bool send
  }
)=>Row(
  
  mainAxisAlignment: send?MainAxisAlignment.end:MainAxisAlignment.start,
  children: [
    send?Flexible(child: Container()):Container(),
        Flexible(
          flex: 3,
          child: Container(
            
              decoration: BoxDecoration(
            
          color: send?primaryColor:Color(0xffEFEFF4),
            
          borderRadius: BorderRadius.circular(20)
            
              ),
            
              margin: const EdgeInsets.only(left: 16,right: 16, top: 10),
            
              padding: const EdgeInsets.all(16),
            
              child: Text("Hello adasdad a sad asd asd asd asd asd asd asd asd ",
        
            
              style: send?f15TextWhiteRegular:f15TextBlackRegular,
            
              
            
              
            
              ),
            
            
            
            
            
              ),
        ),
    send?Container():Flexible(child: Container())    
  ],
);