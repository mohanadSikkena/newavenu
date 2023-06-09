import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/property_model.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget propertyWidget(
    {required BuildContext context ,required Property property}) {
      PropertiesCubit cubit=PropertiesCubit.get(context);
  return Container(
    width: 343.w,
    margin:  EdgeInsets.only(
        top: 17.h,
        right: 16.w),
    height:315.h,
    child: InkWell(
      radius: 10.r,
      onTap: () {
            PropertiesCubit.get(context).getProperty(property.id, context);
      },
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 224.h,
            margin: EdgeInsets.only(bottom: 8.h),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CarouselSlider.builder(
                    itemCount: property.images.length,
                    itemBuilder: (context, i, j) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: DecorationImage(
                              image: NetworkImage(
                                property.images[i]
                              ),
                              fit: BoxFit.cover,
                            )),
                      );
                    },
                    options: CarouselOptions(

                        height: 224.h,
                        enableInfiniteScroll: false,
                        onPageChanged: (i, j) {
                          cubit.changeHomePagePropertiesImage(i, property);
                        },
                        viewportFraction: 1)),
                Padding(
                  padding:  EdgeInsets.only(bottom:16.0.h),
                  child: AnimatedSmoothIndicator(
                      effect: ScrollingDotsEffect(
                        dotWidth: 7.h,
                        dotHeight: 7.h,
                          dotColor: gray_2, activeDotColor: gray_3),
                      activeIndex: property.currentImage,
                      count: property.images.length
                      ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 10,),
          Row(
            children: [
              Text(
            '${property.area} Sqm ',
            style: f13TextGrayRegular_1,
          ),

          Text(
            property.subCategory,
            style: f13TextGrayRegular_1,
          ),
          ],
          ),
          Text(
            property.location,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            property.price,
            style: f15TextgrayRegular_3,
          ),
        ],
      ),
    ),
  );
}
