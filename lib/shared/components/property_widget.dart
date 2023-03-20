import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/property_model.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget propertyWidget(
    {required BuildContext context ,required Property property}) {
      PropertiesCubit cubit=PropertiesCubit.get(context);
  return InkWell(
    onTap: () {
          PropertiesCubit.get(context).getProperty(property.id, context);
    },
    child: Container(
      margin: const EdgeInsets.only(
          top: 17,
          right: 16),
      height:315,
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
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    property.images[i]
                                  ),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          const  Image(
                            image: AssetImage('images/black_logo.png' ) ,)
                        ],
                      );
                    },
                    options: CarouselOptions(
                      
                        enableInfiniteScroll: false,
                        onPageChanged: (i, j) {
                          cubit.changeHomePagePropertiesImage(i, property);
                        },
                        viewportFraction: 1)),
                AnimatedSmoothIndicator(

                    effect: ScrollingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                        dotColor: gray_2, activeDotColor: gray_3),
                    activeIndex: property.currentImage,
                    count: property.images.length
                    ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
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
