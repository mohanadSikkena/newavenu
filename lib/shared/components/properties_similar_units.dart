import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/property_model.dart';

import '../../main.dart';
import '../../modules/properties/property_screen.dart';


class SimilarUnit extends StatelessWidget {
  SimilarProperty property;
   SimilarUnit({
    required this.property,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,
      margin: EdgeInsets.only(right: 16.w),
      child: InkWell(
        onTap: (){
          PropertiesCubit.get(context).getProperty(property.id, context);
          // PropertiesCubit.get(context).getProperty(property.id, context);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 280.w,
              height: 170.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                      image: NetworkImage(
                        property.img,
                      ),
                      fit: BoxFit.cover
                  )
              ),
            ),
            ListTile(
              minVerticalPadding: 0.0,
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),

              title: Text(property.location,),
              subtitle: Text(property.price),
            )
          ],
        ),
      ),
    );
  }
}