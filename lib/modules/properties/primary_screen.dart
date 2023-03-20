import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/main.dart';
import 'package:newavenue/models/properties/properties_cubit.dart';
import 'package:newavenue/models/properties/properties_states.dart';
import 'package:newavenue/shared/components/custom_loading.dart';
import 'package:newavenue/shared/network/remote/dynamic_helper.dart';
import 'package:newavenue/shared/styles/colors.dart';
import 'package:newavenue/shared/styles/styles.dart';
import 'package:url_launcher/url_launcher.dart';


class PrimaryScreen extends StatelessWidget {
  const PrimaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PropertiesCubit cubit = PropertiesCubit.get(context);
    return BlocConsumer<PropertiesCubit, PropertiesStates>(
        builder: (context, states) {
          return Scaffold(
            backgroundColor: black,
            body: cubit.primaryScreenLoading
                ? customLoading()
                : ListView(
                    children: [
                    //   Stack(
                    //     children: [
                    //       CarouselSlider.builder(
                    //           itemCount: cubit.currentPrimary.images.length,
                    //           itemBuilder: (context, i, j) {
                    //             return Container(
                    //               child: InkWell(
                    //                 onTap: () {
                    //                   Navigator.push(context,
                    //                       MaterialPageRoute(builder: (_) {
                    //                     return ImageScreen(
                    //                       images: cubit.currentPrimary.images,
                    //                     );
                    //                   }));
                    //                 },
                    //                 child: Image(
                    //                     loadingBuilder:
                    //                         (context, child, loadingProgress) {
                    //                       return loadingProgress == null
                    //                           ? child
                    //                           : customLoading();
                    //                     },
                    //                     filterQuality: FilterQuality.high,
                    //                     excludeFromSemantics: true,
                    //                     fit: BoxFit.fill,
                    //                     image: NetworkImage(
                    //                         cubit.currentPrimary.images[i])),
                    //               ),
                    //               // ignore: prefer_const_constructors
                    //               decoration: BoxDecoration(
                    //                 border: BorderDirectional(
                    //                     bottom: BorderSide(
                    //                         width: 1, color: gray_3)),
                    //               ),
                    //             );
                    //           },
                    //           options: CarouselOptions(
                    //               height: 404,
                    //               autoPlay: true,
                    //               viewportFraction: 1,
                    //               onPageChanged: (i, k) {
                    //                 cubit.changePrimaryImage(
                    //                     i, cubit.currentPrimary);
                    //               })),
                    //       SizedBox(
                    //         height: 380,
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 IconButton(
                    //                     onPressed: () {
                    //                       Navigator.pop(context);
                    //                     },
                    //                     icon: Icon(
                    //                       Icons.arrow_back_ios,
                    //                       color: white,
                    //                     )),
                    //               ],
                    //             ),
                    //             Container(
                    //               margin: const EdgeInsets.only(left: 16),
                    //               child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Container(
                    //                     alignment: Alignment.center,
                    //                     height: 20,
                    //                     width: 35,
                    //                     decoration: BoxDecoration(
                    //                         color: black,
                    //                         borderRadius:
                    //                             BorderRadius.circular(10)),
                    //                     child: Text(
                    //                       '${cubit.currentPrimary.currentImage + 1}/${cubit.currentPrimary.images.length}',
                    //                       style: f13TextWhiteRegular,
                    //                     ),
                    //                   ),
                    //                   Text(
                    //                     '${cubit.currentPrimary.minSpace} - ${cubit.currentPrimary.maxSpace} Sqm',
                    //                     style: f17TextWhiteMedium,
                    //                   ),
                    //                   Text(
                    //                     cubit.currentPrimary.price,
                    //                     style: f20TextWhiteSemibold,
                    //                   ),
                    //                 ],
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 400,
                    //         child: Align(
                    //           alignment: Alignment.bottomCenter,
                    //           child: AnimatedSmoothIndicator(
                    //               effect: ScrollingDotsEffect(
                    //                   activeDotScale: 1.2,
                    //                   dotWidth: 12,
                    //                   dotHeight: 12,
                    //                   dotColor: gray_2,
                    //                   activeDotColor: gray_3),
                    //               activeIndex:
                    //                   cubit.currentPrimary.currentImage,
                    //               count: cubit.currentPrimary.images.length),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ],
                    
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){
                          navigatorKey.currentState!.pop(context);
                        }, icon: Icon(Icons.arrow_back_ios , color: white,)), 
                        IconButton(onPressed: (){
                          HelperClass helperClass=HelperClass();
                          helperClass.createDynamicLink(id: cubit.currentPrimary.id, category: 'primary').then((value) {
                            helperClass.shareData(messege: value,);
                          });

                        }, icon: Icon(
                          Icons.share, color: white,
                        ))
                      ],
                    ),
                    Column(
                      children: List.generate(cubit.currentPrimary.images.length, 
                      (index) {
                        return Container(
                          
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image(
                                image: 
                              NetworkImage(cubit.currentPrimary.images[index]
                              )),
                             const  Image(
                                height: 200, 
                                width: 200,
                                image: AssetImage('images/black_logo.png' ,) , fit: BoxFit.cover,)
                            ],
                          ),
                        );
                      }),
                    )
                    ,
                    Container(
                                  margin:
                                      const EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    "Developer Name : ${cubit.currentPrimary.developerName}",
                                    style: f15TextWhiteRegular,
                                  )),
                                  Container(
                                  margin:
                                      const EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    "Project Name : ${cubit.currentPrimary.name}",
                                    style: f15TextWhiteRegular,
                                  )),
                    Container(
                                  margin:
                                      const EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    "Location : ${cubit.currentPrimary.location}",
                                    style: f15TextWhiteRegular,
                                  )),
                          Container(
                                  margin:
                                      const EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    "Payment Plan : ${cubit.currentPrimary.paymentPlan}",
                                    style: f15TextWhiteRegular,
                                  )),
                          
                          Container(
                                  margin:
                                      const EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    "Address : ${cubit.currentPrimary.address}",
                                    style: f15TextWhiteRegular,
                                  )),
                          Container(
                                  margin:
                                      const EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    "Min Space : ${cubit.currentPrimary.minSpace}",
                                    style: f15TextWhiteRegular,
                                  )),
                          Container(
                                  margin:
                                      const EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    "Max Space : ${cubit.currentPrimary.maxSpace}",
                                    style: f15TextWhiteRegular,
                                  )),
                          Container(
                                  margin:
                                      const EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    "Average Price Per Meter: ${cubit.currentPrimary.price}",
                                    style: f15TextWhiteRegular,
                                  )),
                        

                        Container(
                                  margin:
                                      const EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    "Delivery Date : ${cubit.currentPrimary.deliveryDate}",
                                    style: f15TextWhiteRegular,
                                  )),
                          const SizedBox(
                          height: 16,
                        ),

                          Container(
              margin: const EdgeInsets.only(left: 16,right: 16),
              height:50,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: 
                        const 
                        BorderRadius.only(topLeft: Radius.circular(10),
                        bottomLeft:  Radius.circular(10) )
                      ),
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          border: BorderDirectional(end: BorderSide(
                            color: gray_2,width: 1
                          ))
                        ),
                        child: InkWell(
                          onTap: ()async{
                            HelperClass helperClass=HelperClass();
                            String messege=await helperClass.createDynamicLink(category: 'primary' , id: cubit.currentPrimary.id);
                            await launchUrl(Uri.parse("whatsapp://send?phone=" + cubit.phone + "&text=$messege"));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_bubble_rounded,color: white),
                                const SizedBox(width: 10,),
                                Text('Chat',style: f17TextWhiteSemibold,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(10),bottomRight:  Radius.circular(10) )
                      ),
                      height: 50,
                      child: InkWell(
                        onTap: ()async{
                          await launchUrl(Uri(scheme: 'tel',path: cubit.phone));

                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.call,color: white),
                                const SizedBox(width: 10,),
                                Text('Call',style: f17TextWhiteSemibold,)
                            ],
                          ),
                      ),
                    ),
                  )
                  ],
              ),
            ),
            
            
            const SizedBox(height: 10,)
          
                    
                    ]


                 
                  ),
          );
        },
        listener: (context, states) {});
  }
}
