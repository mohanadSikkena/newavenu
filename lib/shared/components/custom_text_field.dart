

import 'package:flutter/material.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';



Widget customTextField({
  bool obSecure=false,
  bool readOnly=false,
  bool blackText=false,
  bool search=true,
  TextEditingController? controller ,
   FocusNode ?node,
   Function? onTapFunction,
   Function? onSubmit,
   Key?key,
   
  
  required String text,})=>
TextFormField(
  
  key: key,

  validator: (value){

      if(value!.isEmpty){

        return 'This field is required';

      }
      return null;

    },
  obscureText: obSecure,
  controller: controller,
  onFieldSubmitted: (done){
    onSubmit==null?null: onSubmit();
  },
  

  cursorColor: gray_1,
  readOnly: readOnly,
  focusNode: node,
  onTap: (){
        // onTapFunction?? onTapFunction!();
        onTapFunction==null?null:onTapFunction();
        
      },

      // key: key,
      style:f17TextBlackRegular ,
      decoration: InputDecoration(
        
        contentPadding: EdgeInsets.zero,
        errorStyle:const TextStyle(color: Colors.red, fontSize: 15, fontFamily: ' '),
        filled: true,
        
        fillColor: const Color(0xffEFEFF4),
        

          // ignore: prefer_const_constructors
          prefixIcon: search?Icon(
            Icons.search,
            color: gray_1,
          ):null,

          border: OutlineInputBorder(
            

              borderRadius: BorderRadius.circular(10),

              borderSide: BorderSide.none),


          labelText: text,
          
          labelStyle:blackText?

          f17TextBlackRegular
          :f17TextGrayRegular_1

      ),

    );
  