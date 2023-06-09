

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newavenue/models/primary/primary_cubit.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/shared/components/custom_loading.dart';

import '../../models/ads/ad_model.dart';

Widget adWidget({
  required BuildContext context, 
  required Ad ad

})=> 
  GestureDetector(
    onTap:(){
      PrimaryCubit.get(context).getPrimaryProperty(id: ad.id, context: context);
    } ,
    child: Image(
      loadingBuilder: ((context, child, loadingProgress) {
          return loadingProgress ==null?child:customLoading();
      }),
      image: NetworkImage(ad.image, )),
  );