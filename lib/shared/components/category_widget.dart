

import 'package:flutter/material.dart';

import '../styles/styles.dart';


Widget  categoryWidget(
  {

    required String name,
    required String image,
    required Function function,

  }
)=>InkWell(
  onTap: (){
    function();
  },
  child:   Container(
  
    height: 188,
  
    width: 138,
  
    margin: const EdgeInsets.only(right:16),
  
    decoration: BoxDecoration(
  
      borderRadius: BorderRadius.circular(10),
  
      image: DecorationImage(image: NetworkImage(image,),fit: BoxFit.fill)
  
    ),
  
    child: Padding(
  
      padding: const EdgeInsets.only(left:16,bottom: 16),
  
  
  
      child: Column(
  
        mainAxisAlignment: MainAxisAlignment.end,
  
        crossAxisAlignment: CrossAxisAlignment.start,
  
        children: [
  

  
          Text(name,style:f17TextWhiteSemibold,),
  
  
        ],
  
      ),
  
    ),
  
  
  
  
  
  
  
  ),
);