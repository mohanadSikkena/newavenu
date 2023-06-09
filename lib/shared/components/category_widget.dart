

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  
    height: 188.h,
  
    width: 138.w,
  
    margin: EdgeInsets.only(right:16.w),
  
    decoration: BoxDecoration(
  
      borderRadius: BorderRadius.circular(10.r),
  
      image: DecorationImage(image: NetworkImage(image,),fit: BoxFit.fill)
  
    ),
  
    child: Padding(

      padding: EdgeInsets.only(left:16.w,bottom: 16.h),



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