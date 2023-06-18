import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newavenue/main.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/modules/agent/agent_details.dart';
import 'package:newavenue/modules/properties/image_screen.dart';
import 'package:newavenue/shared/components/custom_loading.dart';
import 'package:newavenue/shared/components/loading_dialog.dart';
import 'package:newavenue/shared/network/remote/launcher_helper.dart';
import 'package:newavenue/shared/router.dart';
import 'package:newavenue/shared/styles/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/properties/property_model.dart';
import '../../shared/components/properties_similar_units.dart';
import '../../shared/network/remote/dynamic_helper.dart';
import '../../shared/styles/colors.dart';

class PropertyScreen extends StatelessWidget {
   PropertyScreen({Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PropertiesCubit cubit = PropertiesCubit.get(context);
    return BlocConsumer<PropertiesCubit, PropertiesStates>(
        builder: (context, states) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar:AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {
                    cubit.propertyPop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: white,
                  )),
              // shadowColor: Colors.transparent,
              // surfaceTintColor: Colors.transparent,
              actions:cubit.propertyLoading? null: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        cubit.changePropertyFavourite(
                            cubit.currentProperty);
                      },
                      icon: Icon(
                        cubit.currentProperty.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: cubit.currentProperty
                            .isFavourite
                            ? favoriteColor
                            : white,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          loadingDialog(context: context);
                          HelperClass helperClass =
                          HelperClass();
                          helperClass
                              .createDynamicLink(
                              id: cubit
                                  .currentProperty.id,
                              category: 'resail')
                              .then((value) {
                            Navigator.pop(context);
                            helperClass.shareData(
                              messege: value,
                            );
                          });
                        },
                        icon: const Icon(
                          Icons.share,
                          color: white,
                        ))
                  ],
                )
              ],

            ),
              backgroundColor: Theme.of(context).colorScheme.background,
              body: cubit.propertyLoading
                  ? customLoading()
                  : ListView(
                      padding:const EdgeInsets.only(top: 0.0),
                      scrollDirection: Axis.vertical,
                      children: [
                        InkWell(
                          onTap: (){
                            CustomRouter.normalPush(screen: ImageScreen(
                              images:
                              cubit.currentProperty.images,
                            ));
                          },
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 404.h,
                                child: Stack(

                                  children: [
                                    CarouselSlider.builder(
                                        itemCount: cubit.currentProperty.images.length,
                                        itemBuilder: (context, i, j) {
                                          return Container(
                                            child: Image(
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  return loadingProgress == null
                                                      ? child
                                                      : customLoading();
                                                },
                                                filterQuality: FilterQuality.high,
                                                excludeFromSemantics: true,
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    cubit.currentProperty.images[i])),
                                            // ignore: prefer_const_constructors
                                            decoration: BoxDecoration(
                                              border: const BorderDirectional(
                                                  bottom: BorderSide(
                                                      width: 1, color: gray_3)),
                                            ),
                                          );
                                        },
                                        options: CarouselOptions(
                                            height: 404.h,
                                            autoPlay: true,
                                            viewportFraction: 1,
                                            onPageChanged: (i, k) {
                                              cubit.changeHomePagePropertiesImage(
                                                  i, cubit.currentProperty);
                                            })),
                                  IgnorePointer(

                                    child: Container(
                                      height: 404.h,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter, end: Alignment.bottomCenter,
                                              colors: [Colors.transparent, Theme.of(context).colorScheme.background.withOpacity(0.85)],
                                              stops:const [0.58, 1]
                                          )
                                      ),
                                    ),
                                  )
                                  ],
                                  // fit: StackFit.expand,
                                ),
                              ),
                              SizedBox(
                                height: 380,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.end,
                                  children: [

                                    Container(
                                      margin: const EdgeInsets.only(left: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            height: 20,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                color: black,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              '${cubit.currentProperty.currentImage + 1}/${cubit.currentProperty.images.length}',
                                              style: f13TextWhiteRegular,
                                            ),
                                          ),
                                          Text(
                                            '${cubit.currentProperty.area} Sqm',
                                            style: Theme.of(context).textTheme.bodyLarge,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                cubit.currentProperty.price,
                                                style: Theme.of(context).textTheme.displaySmall,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                height: 20,
                                                width: 80,
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                margin: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  cubit.currentProperty.saleType,
                                                  style: f13TextWhiteMedium,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            cubit.currentProperty.subCategory,
                                            style: Theme.of(context).textTheme.labelLarge,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 400.h,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: AnimatedSmoothIndicator(
                                      effect: ScrollingDotsEffect(
                                          activeDotScale: 1.2,
                                          dotWidth: 8.h,
                                          dotHeight: 8.h,
                                          dotColor: gray_2,
                                          activeDotColor: gray_3),
                                      activeIndex:
                                          cubit.currentProperty.currentImage,
                                      count: cubit.currentProperty.images.length),
                                ),
                              )
                            ],
                          ),
                        ),

                        // ignore: prefer_const_constructors
                        ListTile(
                          onTap: () {
                            cubit.getAgentProperties(
                                cubit.currentProperty.agent.id);
                            CustomRouter.normalPush(screen: AgentDetails(
                              agent: cubit.currentProperty.agent,
                            ));
                          },

                          contentPadding:
                              const EdgeInsets.only(left: 0.0, right: 0.0),
                          // ignore: prefer_const_constructors
                          leading: CircleAvatar(
                            child: Image(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  cubit.currentProperty.agent.img,
                                )),
                            radius: 40,
                          ),
                          title: Text(
                            cubit.currentProperty.agent.name,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          subtitle: Text(
                            cubit.currentProperty.agent.about,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 16, top: 16),
                            child: Text(
                              'Description ',
                              style: f15TextGraySemibold_1,
                            )),
                        Container(
                            margin: const EdgeInsets.only(left: 16, top: 16),
                            child: Text(
                              cubit.currentProperty.description,
                              style: Theme.of(context).textTheme.labelMedium,
                            )),

                        Row(
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.only(left: 16, top: 16),
                                child: Text(
                                  "License :",
                                  style: Theme.of(context).textTheme.labelMedium,
                                )),
                            Container(
                                margin: const EdgeInsets.only(left: 4, top: 16),
                                child: Text(
                                  cubit.currentProperty.licence,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.labelMedium,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.only(left: 16, top: 16),
                                child: Text(
                                  "Finishing :",
                                  style: Theme.of(context).textTheme.labelMedium,
                                )),
                            Container(
                                margin: const EdgeInsets.only(left: 4, top: 16),
                                child: Text(
                                  cubit.currentProperty.finish,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.labelMedium,
                                )),
                          ],
                        ),

                        for (int i = 0;
                            i < cubit.currentProperty.details.length;
                            i++)
                          Row(
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    cubit.currentProperty.details[i]["name"] +
                                        " :",
                                    style: Theme.of(context).textTheme.labelMedium,
                                  )),
                              Container(
                                  margin:
                                      const EdgeInsets.only(left: 4, top: 16),
                                  child: Text(
                                    cubit.currentProperty.details[i]["details"],
                                    style: Theme.of(context).textTheme.labelMedium,
                                  )),
                            ],
                          ),

                        if (cubit.currentProperty.features.isNotEmpty)...[
                        Container(
                            margin: const EdgeInsets.only(left: 16, top: 16),
                            child: Text(
                              'Features ',
                              style: f15TextGraySemibold_1,
                            )),
                        Container(
                          margin: const EdgeInsets.only(top: 16, left: 16),
                          height: 56,
                          child: ListView.builder(
                              itemCount: cubit.currentProperty.features.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                return Column(
                                  children: [
                                    featuresWidget(
                                        feature:
                                        cubit.currentProperty.features[i]),
                                  ],
                                );
                                // return Container();
                              }),
                        ),
                        ],
                        Container(
                            margin: const EdgeInsets.only(left: 16, top: 16),
                            child: Text(
                              'Location ',
                              style: f15TextGraySemibold_1,
                            )),
                        Container(
                            margin: const EdgeInsets.only(left: 16, top: 16),
                            child: Text(
                              cubit.currentProperty.location,
                              style: Theme.of(context).textTheme.labelMedium,
                            )),


                        Container(
                            margin: const EdgeInsets.only(left: 16, top: 16),
                            child: Text(
                              'Similar Units',
                              style: Theme.of(context).textTheme.displaySmall,
                            )),
                       Container(
                         height: 230.h,
                           decoration: BoxDecoration(
                               // color: Colors.grey,
                               borderRadius: BorderRadius.circular(10.r)
                           ),
                         margin: EdgeInsets.only(left: 16.w, right: 16.w,top: 16.h),
                         // color: Colors.grey,
                         child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                             itemCount: cubit.currentProperty.similarProperties.length,
                             itemBuilder: (context,i)=>SimilarUnit(property: cubit.currentProperty.similarProperties[i]))
                       ),

                        Container(
                          margin: EdgeInsets.only(left: 16.w, right: 16.w,top: 16.h),
                          height: 50.h,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10))),
                                  height: 50.h,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: BorderDirectional(
                                            end: BorderSide(
                                                color: gray_2, width: 1))),
                                    child: InkWell(
                                      onTap: () async {
                                        loadingDialog(context: context);
                                        HelperClass helperClass = HelperClass();
                                        String message = await helperClass
                                            .createDynamicLink(
                                            category: "resail",
                                            id: cubit.currentProperty.id)
                                            .then((value) {
                                          Navigator.pop(context);
                                          return value;
                                        });
                                        await LauncherHelper.launchWhatsapp(
                                          context: context, msg: message,);

                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.chat_bubble_rounded,
                                              color: white),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Chat',
                                            style: f17TextWhiteSemibold,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  height: 50.h,
                                  child: InkWell(
                                    onTap: () async {
                                      await launchUrl(Uri(
                                          scheme: 'tel', path: cubit.phone));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.call, color: white),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Call',
                                          style: f17TextWhiteSemibold,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ));
        },
        listener: (context, states) {});
  }
}


Widget featuresWidget({required String feature}) => Flexible(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text(
          feature,
          style: f13TextPrimarySemibold,
        ),
      ),
    );
