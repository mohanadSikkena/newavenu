

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newavenue/models/primary/primary_cubit.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:share_plus/share_plus.dart';

class HelperClass{
  HelperClass();  
  static bool loading= true;
  static initDynamicLinks({required BuildContext context})async{
    var data=await FirebaseDynamicLinks.instance.getInitialLink();
   if(data==null){
   }else{
    data.link.queryParameters;
    if(data.link.queryParameters.length==2){
        if(data.link.queryParameters['category']=='primary'){
          await PrimaryCubit.get(context).getPrimaryProperty(id:int.parse(data.link.queryParameters['id']!) , context: context);

        }else if(
          data.link.queryParameters['category']=='resail'
        ){
         PropertiesCubit.get(context).getProperty(int.parse(data.link.queryParameters["id"]!), context);
        }
      }
   }
   FirebaseDynamicLinks  dynamicLinks = FirebaseDynamicLinks.instance;

    dynamicLinks.onLink.listen((dynamicLinkData)async { 
      var queryParameters =dynamicLinkData.link.queryParameters;
   
      if(queryParameters.length==2){
        if(queryParameters['category']=='primary'){
          if(loading){
            loading=false;
            await PrimaryCubit.get(context).getPrimaryProperty(id:int.parse(queryParameters['id']!) , context: context);
            loading=true;
          }
        }else if(
          queryParameters['category']=='resail'
        ){
         PropertiesCubit.get(context).getProperty(int.parse(queryParameters["id"]!), context);
        }
      }
    });
   
  }

  Future<String> createDynamicLink({required int id, required String category})async{
    DynamicLinkParameters parameters=DynamicLinkParameters(

      link: Uri.parse("https://newavenueinvestment.page.link?id=$id&category=$category"),
       uriPrefix:'https://newavenueinvestment.page.link', 
       androidParameters: AndroidParameters(
        fallbackUrl: Uri.parse('https://www.newavenue-investment.com'),

        packageName: 'com.example.newavenue' , 

        )
      
      ) ;

      var shortUrl=await FirebaseDynamicLinks.instance.buildShortLink(parameters).then((value) {
         return value.shortUrl;
      });
        return shortUrl.toString();
      
     

  }

  shareData({required String messege,}){
    Share.share(messege
    
    );

  }
}