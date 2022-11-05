

import 'package:flutter/material.dart';
import 'package:newavenue/shared/components/chat_widget.dart';
import 'package:newavenue/shared/components/custom_text_field.dart';
import 'package:newavenue/shared/styles/colors.dart';

import '../../shared/styles/styles.dart';

class ConnectionsScreen extends StatelessWidget {
  const ConnectionsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16),
          child: ListView(

            children: [
              const   SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
          
                  Text(
                      '\nFind Agent',
                      style: f17TextBlackRegular
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:20.0),
                      child: Text(
                  '\nNews',
                  style: f17TextBlackRegular,
                ),
                    ),
                ],
              ),
              const SizedBox(height: 5,),
              Text('Browse',
              style:f34DisplayBlackBold
              ),
              const SizedBox(height: 15,),
              customTextField(
                controller: TextEditingController(), 
                node: FocusNode(), 
                onTapFunction: (){}, 
                onSubmit: (){}, 
                text: 'Search'),
                ListView.builder(   
                                 
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: ((context, index) => chatWidget(context))),
          
              
            ],
        
          ),
        ),
      ),

    );
  }
}