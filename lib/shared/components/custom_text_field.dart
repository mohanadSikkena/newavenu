

import 'package:flutter/material.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';



Widget customTextField({
  bool obSecure=false,
  bool readOnly=false,
  bool blackText=false,
  bool search=true,
  double height=40,
  double marginRight=16,
  double marginLeft=0,
  required TextEditingController controller ,
  required FocusNode node,
  required Function onTapFunction,
  required Function onSubmit,
  
  required String text,})=>
Container(
  
  height: height,


  margin: EdgeInsets.only(top: 10,right: marginRight,left:marginLeft ),
  
  decoration: BoxDecoration(
    
              color: const Color(0xffEFEFF4),
              borderRadius: BorderRadius.circular(6)
            ),
  child:TextFormField(

    validator: (value){
  
        if(value!.isEmpty){
  
          return 'this field required';
  
        }
        return null;
  
      },
    
     
    
    obscureText: obSecure,
    controller: controller,
    onFieldSubmitted: (done){
      onSubmit();
    },
    

    cursorColor: gray_1,
    readOnly: readOnly,
    focusNode: node,
    onTap: (){
          onTapFunction();
          
        },
  
        // key: key,
  
        decoration: InputDecoration(
          
          
  
            prefixIcon: search?Icon(
              Icons.search,
              color: gray_1,
            ):null,
  
            border: OutlineInputBorder(
              
  
                borderRadius: BorderRadius.circular(10),
  
                borderSide: BorderSide.none),
  
            errorBorder: OutlineInputBorder(
  
                borderRadius: BorderRadius.circular(10),
  
                borderSide: const BorderSide(color: Colors.red,width: 0.5)
  
            ),
  
            labelText: text,
            labelStyle:blackText?
  
            f17TextBlackRegular
            :f17TextGrayRegular_1
  
        ),
  
      ),
);
  