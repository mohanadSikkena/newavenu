

import 'package:flutter/material.dart';
import 'package:newavenue/modules/connections/messege.dart';
import 'package:newavenue/shared/components/custom_text_field.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';

class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration:  BoxDecoration(
              border: BorderDirectional(bottom: BorderSide(color: gray_2, width: 0.5))
            ),
            child: Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: const Icon(Icons.arrow_back_ios) , color: black,iconSize: 28,),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: gray_2,
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                      Text('Mexstuff Widstut', style: f17TextBlackSemibold,),
                      Text('Orange Property asd asd asd asd asd asd asd asd asd asd asd asd', 
                      style:    f11TextGrayRegular_1,
                      
                      overflow: TextOverflow.ellipsis,
                      
                      )
                    ],
                  ),
                )
          
              ],
          
            ),
          ),

          Expanded(child: 
          ListView.builder(
            itemCount: 10,

            itemBuilder: (context,i){
              return messegeWidget(send: i%2==0);
            }
            )
            ),
            Container(
              decoration: BoxDecoration(
                border: BorderDirectional(top: BorderSide(color: gray_2,width: 1))
              ),
              padding: EdgeInsets.only(bottom: 5),
              alignment: Alignment.center,
              height: 50,
              child: Row(
                children: [
                  Expanded(child: customTextField(
                    controller: TextEditingController(), 
                    node: FocusNode(), 
                    onTapFunction: (){}, 
                    onSubmit: (){}, 
                    marginLeft: 16,
                    text: 'Write a comment'),),
                    IconButton(onPressed: (){}, 
                    icon: Icon(Icons.send), 
                    color: primaryColor,)

                    
                ],
              ),
            )
          
          
        ],
      ),

    );
  }
}

