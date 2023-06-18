import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newavenue/models/primary/primary_cubit.dart';
import 'package:newavenue/models/primary/primary_model.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';


class SimilarProject extends StatelessWidget {
  SimilarPrimary property;
  SimilarProject({
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
          PrimaryCubit.get(context).getPrimaryProperty(id: property.id, context: context);
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
                        property.image,
                      ),
                      fit: BoxFit.cover
                  )
              ),
            ),
            ListTile(
              minVerticalPadding: 0.0,
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),

              title: Text(property.name,),

              subtitle: Text(property.price),
            )
          ],
        ),
      ),
    );
  }
}