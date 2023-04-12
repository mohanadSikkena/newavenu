

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newavenue/models/primary/primary_cubit.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/primary/primary_model.dart';
import '../styles/colors.dart';
import '../styles/styles.dart';

Widget primaryWidget(
    {
      required BuildContext context ,required ExplorePrimary property,}) {
      PrimaryCubit cubit=PrimaryCubit.get(context);
  return InkWell(
    onTap: () {
      cubit.getPrimaryProperty(id: property.id, context: context);
      
    },
    child: Container(
      margin: const EdgeInsets.only(
          top: 17,
          right: 16),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CarouselSlider.builder(
                    itemCount: property.images.length,
                    itemBuilder: (context, i, j) {

           
                      return Container(
                        child:const Image(image: AssetImage('images/black_logo.png')),
                        width: double.infinity,
                        // height: 224,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                property.images[i]
                              ),
                              fit: BoxFit.cover,
                            )),
                      );
                    },
                    options: CarouselOptions(
  
                      
                        onPageChanged: (i, j) {
                          cubit.changeHomePagePrimaryImage(i, property);
                        },
                        viewportFraction: 1)),
                AnimatedSmoothIndicator(
                    effect: ScrollingDotsEffect(
                      dotHeight: 10, 
                      dotWidth: 10,
                        dotColor: gray_2, activeDotColor: gray_3),
                    activeIndex: property.currentImage,
                    count: property.images.length),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            '${property.minSpace} - ${property.maxSpace} Sqm',
            style: f13TextGrayRegular_1,
          ),
          Text(
            property.name,
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
