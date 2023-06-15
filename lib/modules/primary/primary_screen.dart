import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newavenue/models/primary/primary_cubit.dart';
import 'package:newavenue/models/primary/primary_states.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/shared/components/custom_loading.dart';
import 'package:newavenue/shared/components/loading_dialog.dart';
import 'package:newavenue/shared/network/remote/dynamic_helper.dart';
import 'package:newavenue/shared/network/remote/launcher_helper.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import '../properties/image_screen.dart';

class PrimaryScreen extends StatelessWidget {
  const PrimaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PrimaryCubit cubit = PrimaryCubit.get(context);
    return BlocConsumer<PrimaryCubit, PrimaryStates>(
        builder: (context, states) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              // backgroundColor: Theme.of(context).colorScheme.background,
              leading: IconButton(
                  onPressed: () {
                    navigatorKey.currentState!.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: white,
                  )),
              // shadowColor: Colors.transparent,
              // surfaceTintColor: Colors.transparent,
              actions: [
                IconButton(
                    onPressed: () {
                      loadingDialog(context: context);
                      HelperClass helperClass = HelperClass();
                      helperClass
                          .createDynamicLink(
                              id: cubit.currentPrimary.id, category: 'primary')
                          .then((value) {
                        Navigator.pop(context);
                        helperClass.shareData(
                          messege: value,
                        );
                      });
                    },
                    icon:const Icon(
                      Icons.share,
                      color: white,
                    ))
              ],
            ),
            body: cubit.primaryScreenLoading
                ? customLoading()
                : SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Stack(
                        children: [
                          CarouselSlider.builder(
                              itemCount: cubit.currentPrimary.images.length,
                              itemBuilder: (context, i, j) {
                                return Container(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return ImageScreen(
                                          images: cubit.currentPrimary.images,
                                        );
                                      }));
                                    },
                                    child: Image(
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          return loadingProgress == null
                                              ? child
                                              : customLoading();
                                        },
                                        filterQuality: FilterQuality.high,
                                        excludeFromSemantics: true,
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            cubit.currentPrimary.images[i])),
                                  ),
                                  // ignore: prefer_const_constructors
                                  decoration: BoxDecoration(
                                    border: const BorderDirectional(
                                        bottom: BorderSide(
                                            width: 1, color: gray_3)),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                  enableInfiniteScroll: false,
                                  height: 404.h,
                                  autoPlay: true,
                                  viewportFraction: 1,
                                  onPageChanged: (i, k) {
                                    cubit.changePrimaryImage(
                                        i, cubit.currentPrimary);
                                  })),
                          SizedBox(
                            height: 400.h,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: AnimatedSmoothIndicator(
                                  effect: ScrollingDotsEffect(
                                      activeDotScale: 1.2,
                                      dotWidth: 8.w,
                                      dotHeight: 8.w,
                                      dotColor: gray_2,
                                      activeDotColor: gray_3),
                                  activeIndex:
                                      cubit.currentPrimary.currentImage,
                                  count: cubit.currentPrimary.images.length),
                            ),
                          )
                        ],
                      ),

                      // Flexible(
                      //   child: Card(
                      //     margin:const EdgeInsets.only(top: 16 , left: 4 , right: 4,bottom: 4),

                      //     child: GridView.count(
                      //       mainAxisSpacing: 0.0,
                      //        childAspectRatio: 3,
                      //       crossAxisCount: 2,
                      //       shrinkWrap: true,
                      //       padding: EdgeInsets.zero,
                      //       physics: const NeverScrollableScrollPhysics(),
                      //       children: [

                      //           customListTile(name: 'Project Name', data: cubit.currentPrimary.name),
                      //           customListTile(name: 'Developer Name', data: cubit.currentPrimary.developerName),
                      //           customListTile(name: 'Location', data: cubit.currentPrimary.location),
                      //           customListTile(name: 'Property Type', data: cubit.currentPrimary.propertyType),

                      //         // Add more ListTiles as needed
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      Card(
                        color: Theme.of(context).cardColor,
                        elevation: 1,
                        child: ExpansionTile(
                          initiallyExpanded: true,
                          // initiallyExpanded: cubit.selectedExpansion==ExpansionControl.specifications,
                          // onExpansionChanged: (value){
                          //   cubit.changeSelectedExpansion(value:value?ExpansionControl.specifications:ExpansionControl.none );
                          //
                          // },
                          // collapsedBackgroundColor:Colors.transparent ,

                          // backgroundColor: Colors.transparent,

                          title: Text("Property Specifications",style: TextStyle(fontSize: 16.h),),


                          children: [
                            GridView.count(
                              mainAxisSpacing: 0.0,
                              childAspectRatio: 3,
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                customListTile(
                                    name: 'Project Name',
                                    data:
                                        cubit.currentPrimary.name),
                                customListTile(
                                    name: 'Minimum Space',
                                    data:
                                        cubit.currentPrimary.minSpace),
                                customListTile(
                                    name: 'Maximum Space',
                                    data: cubit.currentPrimary.maxSpace),
                                customListTile(
                                    name: 'Property Type',
                                    data: cubit.currentPrimary.primaryType),

                                // Add more ListTiles as needed
                              ],
                            ),
                          ],
                        ),
                      ),

                      Card(
                        color: Theme.of(context).cardColor,
                        elevation: 1,
                          child: ExpansionTile(

                          // collapsedBackgroundColor:Colors.transparent ,
                          // initiallyExpanded: cubit.selectedExpansion==ExpansionControl.pricing,
                          // onExpansionChanged: (value){
                          //   cubit.changeSelectedExpansion(value:value?ExpansionControl.pricing:ExpansionControl.none );
                          //
                          // },

                          // backgroundColor: Colors.transparent,

                          title: Text("Pricing Details",style: TextStyle(fontSize: 16.h)),

                          children: [
                            GridView.count(
                              mainAxisSpacing: 0.0,
                              childAspectRatio: 3,
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                customListTile(
                                    name: 'minPricePerMeter',
                                    data:
                                        cubit.currentPrimary.minPricePerMeter),
                                customListTile(
                                    name: 'maxPricePerMeter',
                                    data:
                                        cubit.currentPrimary.maxPricePerMeter),
                                customListTile(
                                    name: 'minTotalPrice',
                                    data: cubit.currentPrimary.minTotalPrice),
                                customListTile(
                                    name: 'downPayment',
                                    data: cubit.currentPrimary.downPayment),

                                // Add more ListTiles as needed
                              ],
                            ),
                          ],
                        ),
                      ),

                      Card(
                        color: Theme.of(context).cardColor,
                        elevation: 1,
                        child: ExpansionTile(
                          // collapsedBackgroundColor:Colors.transparent ,

                          // backgroundColor: Colors.transparent,

                          title: Text("Transaction Details",style: TextStyle(fontSize: 16.h)),

                          children: [
                            GridView.count(
                              mainAxisSpacing: 0.0,
                              childAspectRatio: 3,
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                customListTile(
                                    name: 'deliveryDate',
                                    data:
                                        cubit.currentPrimary.deliveryDate),
                                customListTile(
                                    name: 'installment',
                                    data:
                                        cubit.currentPrimary.installment),


                                // Add more ListTiles as needed
                              ],
                            ),
                          ],
                        ),
                      ),
                      Card(
                        color: Theme.of(context).cardColor,
                        elevation: 1,
                        child: ExpansionTile(
                          // collapsedBackgroundColor:Colors.transparent ,

                          // backgroundColor: Colors.transparent,

                          title: Text("Location and Maintenance",style: TextStyle(fontSize: 16.h)),

                          children: [
                            GridView.count(
                              mainAxisSpacing: 0.0,
                              childAspectRatio: 3,
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                customListTile(
                                    name: 'maintenance',
                                    data:
                                        cubit.currentPrimary.maintenance),
                                customListTile(
                                    name: 'location',
                                    data:
                                        cubit.currentPrimary.location),


                                // Add more ListTiles as needed
                              ],
                            ),
                          ],
                        ),
                      ),




                      Container(
                        margin:  EdgeInsets.only(left: 16.w, right: 16.w,top: 16.h),
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
                                              category: "primary",
                                              id: cubit.currentPrimary.id)
                                          .then((value) {
                                        Navigator.pop(context);
                                        return value;
                                      });
                                      await LauncherHelper.launchWhatsapp(
                                        context: context,
                                        msg: message,
                                      );
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
                                        scheme: 'tel',
                                        path: PropertiesCubit.get(context)
                                            .phone));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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

                      SizedBox(
                        height: 10.h,
                      )
                    ]),
                  ),
          );
        },
        listener: (context, states) {});
  }
}

Widget customListTile({required String name, required String data}) {
  return Builder(
      builder: (context) => ListTile(
            key: GlobalKey(),
            title: Text(name, style: Theme.of(context).textTheme.bodyMedium),
            subtitle: Text(
              data,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ));
}
