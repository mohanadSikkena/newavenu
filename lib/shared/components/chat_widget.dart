

import 'package:flutter/material.dart';
import 'package:newavenue/modules/connections/chat_screen.dart';
import 'package:newavenue/shared/styles/styles.dart';


Widget chatWidget(BuildContext context)=>Container(
  height: 60,
  margin: const EdgeInsets.only(top: 10),
  child:   ListTile(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (_){
        return ChatScreen();
      }));
    },
  
    leading: const CircleAvatar(
  
      radius: 23,
  
      backgroundColor: Colors.amber,
  
    ),
  
    title: Row( 
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
      children: [
  
        Text('Agent Name' , style: f15TextBlackSemibold,),
  
        Text('11:20 AM' , style:  f13TextGrayRegular_1,)
  
      ],
  
      
  
    ),
  
    subtitle: Text('Last Messege' , 
    style: f13TextGrayRegular_1,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
     
     ),
  
  ),
);