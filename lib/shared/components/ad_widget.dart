

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/property_model.dart';
import 'package:newavenue/shared/components/custom_loading.dart';

Widget adWidget({
  required BuildContext context, 
  required Ad ad

})=> 
  GestureDetector(

  
    onTap:(){
      PropertiesCubit.get(context).getProperty(ad.id, context);
    } ,
    child: Image(

      loadingBuilder: ((context, child, loadingProgress) {
          return loadingProgress ==null?child:customLoading();
      }),
      image: NetworkImage(ad.image, )),
  );