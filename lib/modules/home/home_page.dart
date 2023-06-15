import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:newavenue/models/ads/ads_cubit.dart';
import 'package:newavenue/models/ads/ads_states.dart';
import 'package:newavenue/models/categories/categories_cubit.dart';
import 'package:newavenue/models/locations/locations_cubit.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/shared/components/ad_widget.dart';
import 'package:newavenue/shared/components/category_widget.dart';
import 'package:newavenue/shared/components/custom_loading.dart';
import 'package:newavenue/shared/components/custom_text_field.dart';
import 'package:newavenue/shared/components/nearby_widget.dart';
import 'package:newavenue/shared/components/property_widget.dart';
import 'package:newavenue/shared/constant.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';

class HomePage extends StatelessWidget {
   const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PropertiesCubit cubit = PropertiesCubit.get(context);

    return BlocConsumer<PropertiesCubit, PropertiesStates>(
        builder: (context, states) {
          return Scaffold(
            extendBodyBehindAppBar: false,

            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              backgroundColor: Theme.of(context).colorScheme.background,
              elevation: 0.0,
              leading: IconButton(
              onPressed: () => ZoomDrawer.of(context)!.toggle(),
              icon: const Icon(Icons.menu),
            ),
              centerTitle: true,
              title: Image.asset(
               Theme.of(context).colorScheme.background==white? "images/black_logo_crop.png":"images/white_logo_crop.png",
                width: 110.w,),
            ),



            // backgroundColor: white,
            body: RefreshIndicator(


              onRefresh:()async{
                AdsCubit.get(context).getAds();
                cubit.mostViews();
                cubit.index();
              },
              child: Container(

                alignment: Alignment.centerLeft,
                margin:  EdgeInsets.only(
                  left: 16.w,
                ),
                child: ListView(
                  physics:const AlwaysScrollableScrollPhysics(),
                  controller: cubit.scrollController
                    ..addListener(() {

                      if (cubit.scrollController.offset ==
                              cubit.scrollController.position.maxScrollExtent &&
                          !cubit.loadingPage &&
                          cubit.count > cubit.homeProperties.length) {
                        cubit.getHomeProperties();
                      }
                    }),
                  children: [
                     SizedBox(
                      height: 10.h,
                    ),
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Padding(
                    //       padding:EdgeInsets.only(right: 12.0.w),
                    //       child: Image.asset(
                    //           Theme.of(context).colorScheme.background == black
                    //               ? 'images/white_logo_crop.png'
                    //               : 'images/black_logo_crop.png',
                    //           height: 50,
                    //           alignment: Alignment.center),
                    //     ),
                    //
                    //   ],
                    // ),

                    Container(
                      height: 36.h,
                      margin: EdgeInsets.only(right: 16.w,bottom: 16.h),
                      child: customTextField(
                        controller: TextEditingController(),
                        onSubmit: () {},
                        node: cubit.homePageSearchNode,
                        readOnly: true,
                        onTapFunction: () {
                          cubit.homePageSearchFunction(context);
                        },
                        text: 'Search...',
                      ),
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categories',
                          style: f15TextGraySemibold_1,
                        ),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15.h,bottom: 16.h),
                        height: 188.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            categoryWidget(
                                name: Constant.categories[0]['name'],
                                image: Constant.categories[0]['img'],
                                function: () {
                                  LocationCubit.get(context)
                                      .navigateToPrimaryCategories(
                                          context: context);
                                }),
                            categoryWidget(
                                name: Constant.categories[1]['name'],
                                image: Constant.categories[1]['img'],
                                function: () {
                                  CategoriesCubit.get(context)
                                      .navigateToCategories(context: context);
                                })
                          ],
                        )),

                    BlocBuilder<AdsCubit, AdsStates>(
                        builder: (context, states) {
                      return AdsCubit.get(context).adsLoading
                          ? customLoading()
                          : AdsCubit.get(context).ads.isNotEmpty
                              ? CarouselSlider.builder(
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 10),
                                    height: 320.h,
                                  ),
                                  itemCount: AdsCubit.get(context).ads.length,
                                  itemBuilder: (context, i, j) {
                                    return adWidget(
                                        context: context,
                                        ad: AdsCubit.get(context).ads[i]);
                                  })
                              : const SizedBox();
                    }),
                    const SizedBox(height: 16),
                    cubit.mostViewd.isNotEmpty
                        ? Text(
                            'Most Views',
                            style: f15TextGraySemibold_1,
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 15.h,
                    ),
                    cubit.mostViewd.isNotEmpty
                        ? SizedBox(
                            height: 266.h,
                            child: cubit.mostViewsLoading
                                ? customLoading()
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: cubit.mostViewd.length,
                                    itemBuilder: (context, i) {
                                      return nearbyWidget(
                                        property: cubit.mostViewd[i],
                                        context: context,
                                      );
                                    }),
                          )
                        : const SizedBox(),
                    Text(
                      cubit.allPropertiesLoading
                          ? "Loading"
                          : "Explore all ${cubit.count}+ properties",
                      style: f15TextGraySemibold_1,
                    ),
                    cubit.allPropertiesLoading
                        ? customLoading()
                        : Column(
                      mainAxisSize: MainAxisSize.min,
                            children: [
                              for (int i = 0;
                                  i < cubit.homeProperties.length;
                                  i++)
                                propertyWidget(
                                  context: context,
                                  property: cubit.homeProperties[i],
                                ),
                            ],
                          )
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, states) {});
  }
}
